//
//  StoreImages.swift
//  ProficiencyExercise
//
//  Created by Jeni on 20/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import CoreData

@objc(StoreImages)
class StoreImages:NSManagedObject {
    
    // MARK: - Core Data Managed Object
    @NSManaged var imageBinaryData: Data
    @NSManaged var imageUrlString: String
}
