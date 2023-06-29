import Foundation

class PeopleDataRepository {

    // MARK: - Internal methods

    func fetch(_ token: String) -> [Person] {
        return PeopleDataManager.shared.fetch(token)
    }

    func addPerson(_ person: Person) {
        PeopleDataManager.shared.insert(person)
    }

    func deletePerson(_ person: Person) {
        PeopleDataManager.shared.delete(person)
    }

    func save() {
        PeopleDataManager.shared.save()
    }
}
