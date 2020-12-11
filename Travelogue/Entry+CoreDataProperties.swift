//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Patrick McIntosh on 12/9/20.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var content: String?
    @NSManaged public var rawDate: Date?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var trip: Trip?

}

extension Entry : Identifiable {

}
