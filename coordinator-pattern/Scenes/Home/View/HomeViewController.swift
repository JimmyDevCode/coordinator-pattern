import UIKit

final class HomeViewController: UIViewController {

    var onNext: (() -> Void)?

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Inicio"

        // Title
        titleLabel.text = "Bienvenido"
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.textAlignment = .center

        // Subtitle
        subtitleLabel.text = "Activa tu Plan Premium en segundos."
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0

        // Action Button
        actionButton.setTitle("Ver detalles", for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        actionButton.backgroundColor = .systemBlue
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 12
        actionButton.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            actionButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            actionButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func didTapAction() {
        onNext?()
    }
}

#Preview("Home") {
    UINavigationController(
        rootViewController: {
            let vc = HomeViewController()
            vc.onNext = {
                print("Go to Detail")
            }
            return vc
        }()
    )
}
