import Foundation

class PeopleViewModel {

    // MARK: - Properties

    var people: [Person]?
    private lazy var repo = PeopleDataRepository()

    // MARK: - Internal methods

    func addContact(firstName: String, lastName: String, phone: String, token: String) {
        let person = Person(entity: Person.entity(), insertInto: nil)
        person.givenName = firstName
        person.familyName = lastName
        person.phone = phone
        person.token = token
        repo.addPerson(person)
        reloadData(token)
    }

    func updateContact(firstName: String, lastName: String, phone: String, row: Int) {
        let person = people![row]
        person.givenName = firstName
        person.familyName = lastName
        person.phone = phone
        repo.save()
        reloadData(person.token!)
    }

    func deleteContact(row: Int) {
        let person = people![row]
        let token = person.token
        repo.deletePerson(person)
        reloadData(token!)
    }

    func reloadData(_ token: String) {
        self.people = repo.fetch(token)
    }
}
