import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var token: String?
    @NSManaged public var givenName: String?
    @NSManaged public var familyName: String?
    @NSManaged public var phone: String?

}

extension Person : Identifiable {

}
