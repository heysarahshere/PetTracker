//
//  Friend+CoreDataProperties.swift
//  Pet Tracker
//
//  Created by Sarah covey on 3/12/20.
//  Copyright © 2020 Sarah Covey. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var eyeColor: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var pets: NSSet?

}

// MARK: Generated accessors for pets
extension Friend {

    @objc(addPetsObject:)
    @NSManaged public func addToPets(_ value: Pet)

    @objc(removePetsObject:)
    @NSManaged public func removeFromPets(_ value: Pet)

    @objc(addPets:)
    @NSManaged public func addToPets(_ values: NSSet)

    @objc(removePets:)
    @NSManaged public func removeFromPets(_ values: NSSet)

}
