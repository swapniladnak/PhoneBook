import UIKit

class SignInViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userName: UITextField!

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signIn(_ sender: Any) {
        guard let usersData = KeychainWrapper.standard.data(forKey: AuthKeys.userKey),
              let users = try? JSONDecoder().decode([String].self, from: usersData),
              users.contains(userName.text!) else {
            let alert = UIAlertController(title: "Warning", message: "Invalid user name", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }

        guard let token = KeychainWrapper.standard.string(forKey: userName.text! + passWord.text! + AuthKeys.addtionalTokenKey) else {
            let alert = UIAlertController(title: "Warning", message: "Invalid password", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        userName.text = ""
        passWord.text = ""
        let phoneBookViewController = PhoneBookViewController(nibName: "PhoneBookViewController", bundle: nil)
        phoneBookViewController.modalPresentationStyle = .fullScreen
        phoneBookViewController.token = token
        self.present(phoneBookViewController, animated: true)
    }
}

