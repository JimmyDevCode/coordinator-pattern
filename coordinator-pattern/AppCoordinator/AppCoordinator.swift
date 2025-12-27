import UIKit
import SwiftUI
enum AppStartPoint {
    case login
    case home
}
class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var onLoginSuccess: (() -> Void)?
    var onLogout: (() -> Void)?
    
    init(
        navigationController: UINavigationController,
        onLoginSuccess: (() -> Void)? = nil,
        onLogout: (() -> Void)? = nil
    ) {
        self.navigationController = navigationController
        self.onLoginSuccess = onLoginSuccess
        self.onLogout = onLogout
    }
    
    func start(from point: AppStartPoint) {
        switch point {
        case .login:
            showLogin()
        case .home:
            goToHome()
        }
    }
    
    func goToHome() {
        let vc = HomeViewController()
        vc.onNext = { [weak self] in
            self?.goToDetail()}
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToDetail() {
        let vc = DetailViewController()
        vc.onNext = { [weak self] in
            self?.goToCheckout()}
        navigationController.pushViewController(vc, animated: false)
    }
    
    // SwiftUI
    func goToCheckout() {
        let view = CheckoutView(
            onPurchaseButton: goToConfirmation
        )
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToConfirmation() {
        let vc = ConfirmationViewController()
        vc.onLogout = { [weak self] in
            self?.onLogout?()
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showLogin() {
        let vc = LoginViewController()
        vc.onLoginSuccess = { [weak self] in
            self?.onLoginSuccess?()
        }
        navigationController.setViewControllers([vc], animated: false)
    }
}
