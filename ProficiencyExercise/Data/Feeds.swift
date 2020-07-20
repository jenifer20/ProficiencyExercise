//
//  Feeds.swift
//  ProficiencyExercise
//
//  Created by Jeni on 20/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import CoreData

@objc(Feeds)
class Feeds:NSManagedObject, Codable {
    
    // MARK: - Core Data Managed Object
       @NSManaged var title: String
       @NSManaged var summary: String
       @NSManaged var imageHref: String
       
       enum CodingKeys: String, CodingKey {
           case title
           case summary = "description"
           case imageHref
       }
       
       // MARK: - Decodable
       required convenience init(from decoder: Decoder) throws {
           guard let contextUserInfoKey = CodingUserInfoKey.context else { fatalError("cannot find context key") }
           
           guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
           
           guard let entity = NSEntityDescription.entity(forEntityName: "Feeds", in: managedObjectContext) else { fatalError("Fatal Error") }
           
           self.init(entity: entity, insertInto: managedObjectContext)
           
           let container = try decoder.container(keyedBy: CodingKeys.self)
           do {
               self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
               self.summary = try container.decodeIfPresent(String.self, forKey: .summary) ?? ""
               self.imageHref = try container.decodeIfPresent(String.self, forKey: .imageHref) ?? ""
           } catch {
               print("Decode Error")
           }
       }
       
       // MARK: - Encodable
       public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(title, forKey: .title)
           try container.encode(summary, forKey: .summary)
           try container.encode(imageHref, forKey: .imageHref)
       }
}
