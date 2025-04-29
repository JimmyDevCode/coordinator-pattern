import UIKit
class HomeViewController: UIViewController {
    var onNext: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Inicio"
        
        let button = UIButton(type: .system)
        button.setTitle("Ir a Detalle", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func goToDetail() {
        onNext?()
    }
}
