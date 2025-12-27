import UIKit

final class DetailViewController: UIViewController {

    var onNext: (() -> Void)?

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let continueButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        title = "Detalle"

        // Title
        titleLabel.text = "Plan Premium"
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textAlignment = .center

        // Description
        descriptionLabel.text = "Acceso completo a todas las funciones sin límites."
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        // Price
        priceLabel.text = "S/ 29.90"
        priceLabel.font = .systemFont(ofSize: 22, weight: .bold)
        priceLabel.textAlignment = .center

        // Button
        continueButton.setTitle("Continuar al pago", for: .normal)
        continueButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        continueButton.backgroundColor = .systemBlue
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 12
        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            descriptionLabel,
            priceLabel,
            continueButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            continueButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func didTapContinue() {
        onNext?()
    }
}

#Preview("Detail") {
    UINavigationController(
        rootViewController: {
            let vc = DetailViewController()
            vc.onNext = {
                print("Continue tapped")
            }
            return vc
        }()
    )
}
