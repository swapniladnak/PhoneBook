import Foundation
import CoreData

class PeopleDataManager {

    // MARK: - Shared instance

    public static let shared = PeopleDataManager()

    // MARK: - Private Properties

    private lazy var persistenceContainer: NSPersistentContainer = {
        let persistenceContainer = NSPersistentContainer(name: "PeopleDataModel")
        persistenceContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as? NSError {
                fatalError("Unresolved error")
            }
        }
        return persistenceContainer
    }()

    private lazy var context = persistenceContainer.viewContext

    // MARK: - Private init

    private init() {}

    // MARK: - Helper methods

    func insert(_ person: Person) {
        context.insert(person)
        save()
    }

    func delete(_ person: Person) {
        context.delete(person)
        save()
    }

    func fetch(_ token: String) -> [Person] {
        let request = Person.fetchRequest()
        request.predicate = NSPredicate(format: "token MATCHES '\(token)'")
        request.sortDescriptors = [
            NSSortDescriptor(key: "givenName", ascending: true),
            NSSortDescriptor(key: "familyName", ascending: true)]
        do {
            return try context.fetch(request)
        } catch {
            fatalError("Unexception error occured while fetching data \(error)")
        }
    }

    func save() {
        do {
            try context.save()
        } catch {
            fatalError("Unexception error occured \(error)")
        }
    }
}
