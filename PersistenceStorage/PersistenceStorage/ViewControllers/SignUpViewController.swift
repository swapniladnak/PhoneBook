import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUp(_ sender: Any) {
        if userNameTextField.text == "" || passWordTextField.text == "" {
            let alert = UIAlertController(title: "Warning", message: "Please enter the details", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            var users: [String] = []
            if let usersData = KeychainWrapper.standard.data(forKey: AuthKeys.userKey) {
                let decodeUsers = try! JSONDecoder().decode([String].self, from: usersData)
                users.append(contentsOf: decodeUsers)
            }
            guard !users.contains(userNameTextField.text!) else {
                let alert = UIAlertController(title: "Warning", message: "Please enter anothr user name", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .cancel)
                alert.addAction(action)
                present(alert, animated: true)
                return
            }
            users.append(userNameTextField.text!)
            KeychainWrapper.standard.set(try! JSONEncoder().encode(users), forKey: AuthKeys.userKey)
            let token = UUID().uuidString
            KeychainWrapper.standard.set(token, forKey: userNameTextField.text! + passWordTextField.text! + AuthKeys.addtionalTokenKey)
            let alert = UIAlertController(title: "Success", message: "Registration successfull!!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel) { [weak self] _ in
                self?.dismiss(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}
