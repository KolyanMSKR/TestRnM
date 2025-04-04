//
//  CharacterEntity+CoreDataProperties.swift
//  TestRnM
//
//  Created by Anderen on 02.04.2025.
//
//

import Foundation
import CoreData


extension CharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?

}

extension CharacterEntity : Identifiable {

}
