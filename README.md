# Coordinator Pattern

Este proyecto demuestra la implementación del patrón Coordinator en iOS, que ayuda a separar la lógica de navegación de los controladores de vista, promoviendo un código más modular y testable.

## ¿Qué es el Patrón Coordinator?

El patrón Coordinator es un patrón de arquitectura que maneja la navegación y el flujo de la aplicación. En lugar de que los ViewControllers manejen su propia navegación, un Coordinator se encarga de esto, permitiendo que los ViewControllers se concentren únicamente en la presentación de datos y la interacción del usuario.

## Estructura del Proyecto

```
coordinator-pattern/
├── AppCoordinator/
│   ├── Coordinator.swift          # Protocolo base para coordinators
│   └── AppCoordinator.swift       # Coordinator principal de la app
├── Scenes/
│   ├── Home/
│   │   └── View/
│   │       └── HomeViewController.swift
│   ├── Detail/
│   │   └── View/
│   │       └── DetailViewController.swift
│   ├── Checkout/
│   │   └── View/
│   │       └── CheckoutView.swift
│   ├── Confirmation/
│   │   └── View/
│   │       └── ConfirmationViewController.swift
│   └── Login/
│       └── View/
│           └── LoginViewController.swift
```

## Componentes Principales

### 1. Protocolo Coordinator

```swift
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start(from point: AppStartPoint)
}
```

- Define la interfaz que todos los coordinators deben implementar
- `navigationController`: El controlador de navegación que maneja la pila de vistas
- `start(from:)`: Método para iniciar el flujo de navegación desde un punto específico

### 2. AppCoordinator

El `AppCoordinator` es el coordinator principal que:

- Maneja el flujo general de la aplicación
- Decide qué vista mostrar inicialmente basado en el estado de autenticación
- Coordina la navegación entre diferentes escenas
- Gestiona callbacks para eventos como login/logout

**Métodos principales:**
- `start(from:)`: Inicia el flujo desde login o home
- `goToHome()`: Navega a la pantalla principal
- `goToDetail()`: Navega a la pantalla de detalle
- `goToCheckout()`: Navega a la pantalla de checkout (SwiftUI)
- `goToConfirmation()`: Navega a la pantalla de confirmación
- `showLogin()`: Muestra la pantalla de login

### 3. ViewControllers y Views

El proyecto combina ViewControllers de UIKit y Views de SwiftUI:

#### ViewControllers (UIKit)
Cada ViewController tiene responsabilidades claras:

- **Presentación**: Mostrar la UI y datos
- **Interacción**: Manejar eventos del usuario
- **Delegación**: Usar closures para comunicar eventos de navegación al coordinator

Ejemplo en `HomeViewController`:

```swift
var onNext: (() -> Void)?
// ...
@objc func goToDetail() {
    onNext?()  // Delega la navegación al coordinator
}
```

#### Views (SwiftUI)
Las vistas de SwiftUI siguen el mismo patrón de delegación usando closures.

Ejemplo en `CheckoutView`:

```swift
struct CheckoutView: View {
    var onPurchaseButton: (() -> Void)?
    // ...
    private func simulatePayment() {
        // Simula procesamiento de pago
        onPurchaseButton?()  // Delega la navegación al coordinator
    }
}
```

La `CheckoutView` incluye:
- Resumen del producto y precio
- Selección de método de pago (Tarjeta, Transferencia, Billetera digital)
- Simulación de procesamiento de pago
- Callback `onPurchaseButton` para navegación posterior al pago

### Integración de SwiftUI en Coordinators UIKit

Para integrar vistas de SwiftUI en un coordinator basado en UIKit, se utiliza `UIHostingController`:

```swift
func goToCheckout() {
    let view = CheckoutView(onPurchaseButton: goToConfirmation)
    let vc = UIHostingController(rootView: view)
    navigationController.pushViewController(vc, animated: false)
}
```

Esto permite una migración gradual a SwiftUI manteniendo la arquitectura del coordinator intacta.

## Flujo de Navegación

1. **Inicio**: `AppCoordinator.start(from: .login)` o `AppCoordinator.start(from: .home)`
2. **Login**: Si el usuario no está autenticado, muestra `LoginViewController`
3. **Home**: Pantalla principal con opción de ir a detalle
4. **Detail**: Pantalla de detalle con opción de ir a checkout
5. **Checkout**: Pantalla de checkout en SwiftUI con selección de método de pago
6. **Confirmation**: Pantalla final con opción de logout

## Beneficios del Patrón

- **Separación de responsabilidades**: Navegación separada de la lógica de vista
- **Testabilidad**: Los coordinators pueden ser testeados independientemente
- **Reutilización**: Coordinators pueden ser reutilizados en diferentes contextos
- **Mantenibilidad**: Cambios en la navegación no afectan los ViewControllers
- **Escalabilidad**: Fácil agregar nuevos flujos sin modificar código existente

## Uso

Para usar este patrón en tu proyecto:

1. Define el protocolo `Coordinator`
2. Crea coordinators específicos para cada flujo
3. Inyecta el coordinator en los ViewControllers
4. Usa closures o delegates para comunicación entre ViewController y Coordinator

## Frameworks Utilizados

Este proyecto combina UIKit y SwiftUI:

- **UIKit**: ViewControllers para las escenas principales (Home, Detail, Confirmation, Login)
- **SwiftUI**: CheckoutView como ejemplo de integración moderna

Esta mezcla permite migrar gradualmente a SwiftUI manteniendo el patrón Coordinator consistente.

## Adaptación a SwiftUI

El patrón Coordinator puede adaptarse fácilmente a SwiftUI puro usando `NavigationPath` y `ObservableObject` para manejar el estado de navegación de manera reactiva. La `CheckoutView` demuestra cómo las vistas de SwiftUI pueden integrarse en el patrón usando closures para delegar navegación.
