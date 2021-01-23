import Foundation
import CoreData

class DataImporter {
  let importContext: NSManagedObjectContext

  init(persistentContainer: NSPersistentContainer) {
    importContext = persistentContainer.newBackgroundContext()
    importContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
  }
}
