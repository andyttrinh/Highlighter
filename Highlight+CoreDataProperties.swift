//
//  Highlight+CoreDataProperties.swift
//  Highlighter
//
//  Created by Andy Trinh on 9/22/23.
//
//

import Foundation
import CoreData


extension Highlight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Highlight> {
        return NSFetchRequest<Highlight>(entityName: "Highlight")
    }

    @NSManaged public var source: String?
    @NSManaged public var content: String?

}

extension Highlight : Identifiable {

}
