import UIKit

final class ConfirmationViewController: UIViewController {

    var onLogout: (() -> Void)?

    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let finishButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Confirmación"

        // Icon
        iconView.image = UIImage(systemName: "checkmark.circle.fill")
        iconView.tintColor = .systemGreen
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false

        // Title
        titleLabel.text = "Pago realizado"
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textAlignment = .center

        // Message
        messageLabel.text = "Tu compra se procesó correctamente."
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        // Button
        finishButton.setTitle("Finalizar", for: .normal)
        finishButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        finishButton.backgroundColor = .systemBlue
        finishButton.setTitleColor(.white, for: .normal)
        finishButton.layer.cornerRadius = 12
        finishButton.addTarget(self, action: #selector(didTapFinish), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            iconView,
            titleLabel,
            messageLabel,
            finishButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            iconView.heightAnchor.constraint(equalToConstant: 80),
            iconView.widthAnchor.constraint(equalToConstant: 80),

            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            finishButton.widthAnchor.constraint(equalTo: stack.widthAnchor),
            finishButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func didTapFinish() {
        onLogout?()
    }
}

#Preview("Confirmation") {
    UINavigationController(
        rootViewController: {
            let vc = ConfirmationViewController()
            vc.onLogout = {
                print("Flow finished")
            }
            return vc
        }()
    )
}

