//
//  GetInfoResponse.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import CoreData

class GetInfoResponse: Codable {
    
    // MARK: - Core Data Managed Object
//    @NSManaged var title: String?
//    @NSManaged var summary: String?
//    @NSManaged var imageHref: String?
    
    var title: String?
    var summary: String?
    var imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case summary = "description"
        case imageHref
    }
    
    /*// MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Feeds", in: managedObjectContext) else {
            fatalError("Failed to decode Feeds")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        self.imageHref = try container.decodeIfPresent(String.self, forKey: .imageHref)
    }*/

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(summary, forKey: .summary)
        try container.encode(imageHref, forKey: .imageHref)
    }
}

public extension  CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
