import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // La ventana principal de la aplicación.
    // Aquí se define el rootViewController que verá el usuario.
    var window: UIWindow?
    // Referencia al coordinador principal que maneja los flujos de navegación.
    // Este será reiniciado según el punto de entrada que se defina.
    var appCoordinator: Coordinator?
    // Este método se ejecuta cuando la escena se conecta por primera vez.
    // Es el punto de entrada principal de la app en versiones modernas de iOS (13+).
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        // Verifica que la escena sea de tipo UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // Se crea una nueva instancia de UIWindow con la escena obtenida
        let window = UIWindow(windowScene: windowScene)
        // 🔧 Esta línea es CLAVE: se asigna la ventana creada a la propiedad `self.window`
        // Esto mantiene viva la instancia de UIWindow durante el ciclo de vida de la app
        self.window = window
        // Reinicia la aplicación en el punto de entrada `.login`
        restartApp(at: .login)
        // Muestra la ventana en pantalla
        window.makeKeyAndVisible()
    }
    
    private func restartApp(at point: AppStartPoint) {
        // Se crea un nuevo UINavigationController vacío,
        // que será la nueva raíz de navegación de la aplicación.
        let newNav = UINavigationController()
        // Se crea una nueva instancia del coordinador principal (AppCoordinator),
        // pasando el nuevo navigationController y el punto de entrada deseado.
        let newCoordinator = makeCoordinator(for: newNav, at: point)
        // Se inicia el nuevo coordinador desde el punto indicado (por ejemplo: .home o .login),
        // lo que determina a qué flujo debe dirigirse el usuario.
        newCoordinator.start(from: point)
        // Se establece el nuevo UINavigationController como el rootViewController de la ventana.
        // Esto reemplaza toda la jerarquía visual anterior por la nueva.
        window?.rootViewController = newNav
        // Se actualiza la referencia del appCoordinator con el nuevo coordinador creado,
        // asegurando que la app siga manejando el flujo con esta nueva instancia.
        appCoordinator = newCoordinator
    }
    
    private func makeCoordinator(
        for nav: UINavigationController,
        at point: AppStartPoint
    ) -> Coordinator {
        // Este método encapsula la creación del AppCoordinator,
        // y define los callbacks que deben ejecutarse cuando el usuario inicia o cierra sesión.
        // Así se centraliza el manejo del flujo principal de la app.
        return AppCoordinator(
            navigationController: nav,
            // Este closure se ejecuta cuando el login es exitoso.
            // Llama a restartApp con el punto de entrada `.home`,
            // lo que reinicia toda la navegación y posiciona al usuario en la pantalla principal,
            // limpiando cualquier stack de navegación previo.
            onLoginSuccess: { [weak self] in
                self?.restartApp(at: .home) },
            // Este closure se ejecuta cuando el usuario cierra sesión (logout).
            // Reinicia la app en el punto `.login`, asegurando que se muestre la pantalla de autenticación.
            onLogout: { [weak self] in
                self?.restartApp(at: .login) }
        )
    }
}

