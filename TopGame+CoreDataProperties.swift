
import Foundation
import CoreData


extension TopGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopGame> {
        return NSFetchRequest<TopGame>(entityName: "TopGame")
    }

    @NSManaged public var name: String?
    @NSManaged public var score: Int16
    @NSManaged public var longtude: Double
    @NSManaged public var latitude: Double

}
