import UIKit
class ConfirmationViewController: UIViewController {
    var onLogout: (() -> Void)?
    private let modalButton1 = UIButton(type: .system)
    private let modalButton2 = UIButton(type: .system)
    private let modalButton3 = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Confirmación"
        
        let label = UILabel()
        label.text = "Gracias por tu solicitud."
        label.textAlignment = .center
        label.frame = CGRect(x: 50, y: 200, width: 300, height: 50)
        view.addSubview(label)
        
        let button = UIButton(type: .system)
        button.setTitle("Cerrar sesión", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func logoutTapped() {
        onLogout?()
    }
}
