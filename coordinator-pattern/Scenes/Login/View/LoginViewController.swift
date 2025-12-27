import UIKit

final class LoginViewController: UIViewController {

    var onLoginSuccess: (() -> Void)?

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let loginButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Login"

        // Title
        titleLabel.text = "Bienvenido a Coordinator"
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.textAlignment = .center

        // Subtitle
        subtitleLabel.text = "Inicia sesión para continuar."
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0

        // Button
        loginButton.setTitle("Iniciar sesión", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 12
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)

        // Loader
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
        ])

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            loginButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            loginButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func didTapLogin() {
        setLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.setLoading(false)
            self?.onLoginSuccess?()
        }
    }

    private func setLoading(_ isLoading: Bool) {
        loginButton.isEnabled = !isLoading
        loginButton.setTitle(isLoading ? "" : "Iniciar sesión", for: .normal)

        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

#Preview("Login") {
    UINavigationController(
        rootViewController: {
            let vc = LoginViewController()
            vc.onLoginSuccess = {
                print("Login success")
            }
            return vc
        }()
    )
}
