//
//  DataController.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class DataController {
    
    // CoreData Entity Names
    private static let entityName = "Feeds"
    private static let imageStoringEntity = "StoreImages"

    private let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "ProficiencyExercise")
        persistentContainer.loadPersistentStores { storeDescription, error in
            // resolve conflict by using correct NSMergePolicy
            self.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    //MARK:- Mapping Fetched Data into Model Class
    func initViewModels(_ feeds: [Feeds?]) -> [FeedsModel?] {
        return feeds.map { feed in
            if let feed = feed {
                return FeedsModel(feeds: feed)
            } else {
                return nil
            }
        }
    }
    
    func initViewModels(_ images: [StoreImages?]) -> [StoredImagesModel?] {
        return images.map { image in
            if let image = image {
                return StoredImagesModel(images: image)
            } else {
                return nil
            }
        }
    }
    
}

extension DataController {
    //MARK:- Parse Json Data and Store into CoreData with Codable
    func parse(_ jsonData: Data) -> Bool {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context else {
                fatalError("Failed to retrieve managed object context")
            }
            
            clearStorage()

            // Parse JSON data
            let managedObjectContext = persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            _ = try decoder.decode([Feeds].self, from: jsonData)
            try managedObjectContext.save()

            return true
        } catch let error {
            print(error)
            return false
        }
    }
    
    //MARK:- Save Downloaded Image into CoreData
    func saveImageIntoStorage(image: UIImage, urlString: String) -> Bool {
        
        clearImagesStorage()
        
        let managedObjectContext = persistentContainer.viewContext
        guard let images = NSEntityDescription.insertNewObject(forEntityName: DataController.imageStoringEntity, into: managedObjectContext) as? StoreImages else { return false}
        
        let emptyData = Data()
        let imageData = image.pngData()
        images.imageBinaryData = imageData ?? emptyData
        images.imageUrlString = urlString
        
        do {
            try managedObjectContext.save()
            return true
        } catch {
            print("Could not save image. \(error), \(error.localizedDescription)")
        }

        return false
    }
    
    //MARK:- Fetch Data from CoreData
    func fetchFromStorage() -> [Feeds]? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Feeds>(entityName: DataController.entityName)
        do {
            let values = try managedObjectContext.fetch(fetchRequest)
            return values
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func fetchImagesFromStorage() -> [StoreImages]? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<StoreImages>(entityName: DataController.imageStoringEntity)
        do {
            let values = try managedObjectContext.fetch(fetchRequest)
            return values
        } catch let error {
            print(error)
            return nil
        }
    }
    
    //MARK:- Clear Storage of DB
    func clearStorage() {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DataController.entityName)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let users = try managedObjectContext.fetch(fetchRequest)
                for user in users {
                    managedObjectContext.delete(user as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func clearImagesStorage() {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: DataController.imageStoringEntity)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let users = try managedObjectContext.fetch(fetchRequest)
                for user in users {
                    managedObjectContext.delete(user as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
