import UIKit

class PhoneBookViewController: UIViewController {

    // MARK: - Properties

    private lazy var viewModel = PeopleViewModel()
    var token: String?
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Setup methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.reloadData(self.token ?? "")
    }
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableView.addGestureRecognizer(longPress)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Action methods

    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let alert =  UIAlertController(title: "Are you sure for delete contact?", message: nil, preferredStyle: .alert)
                let deleteAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                    self?.viewModel.deleteContact(row: indexPath.row)
                    self?.tableView.reloadData()
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .default)
                alert.addAction(deleteAction)
                alert.addAction(cancelAction)
                present(alert, animated: true)
            }
        }
    }
    
    @IBAction func addContact(_ sender: Any) {
        let alert =  UIAlertController(title: "Add contact details", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "First Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Family Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Phone number"
        }
        let saveAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            self?.viewModel.addContact(
                firstName: (alert.textFields?[0].text)!,
                lastName: (alert.textFields?[1].text)!,
                phone: (alert.textFields?[2].text)!,
                token: (self?.token)!)
            self?.tableView.reloadData()
        }
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
    
    @IBAction func logOutUser(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension PhoneBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.people!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = self.viewModel.people![indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Name: \(person.givenName!) \(person.familyName!)\nPhone Number: \(person.phone!)"
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PhoneBookViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert =  UIAlertController(title: "Edit contact details", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "First Name"
            textField.text = self.viewModel.people![indexPath.row].givenName
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Family Name"
            textField.text = self.viewModel.people![indexPath.row].familyName
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Phone number"
            textField.text = self.viewModel.people![indexPath.row].phone
        }
        let saveAction = UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            self?.viewModel.updateContact(
                firstName: (alert.textFields?[0].text)!,
                lastName: (alert.textFields?[1].text)!,
                phone: (alert.textFields?[2].text)!,
                row: indexPath.row)
            self?.tableView.reloadData()
        }
        alert.addAction(saveAction)
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
