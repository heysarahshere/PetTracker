//
//  Pet+CoreDataProperties.swift
//  Pet Tracker
//
//  Created by Sarah covey on 3/12/20.
//  Copyright © 2020 Sarah Covey. All rights reserved.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var name: String?
    @NSManaged public var dob: Date?
    @NSManaged public var animalKind: String?
    @NSManaged public var owner: Friend?

}
