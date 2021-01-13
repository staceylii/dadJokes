//
//  Jokes+CoreDataProperties.swift
//  dad jokes
//
//  Created by Stacey Li on 12/1/20.
//
//

import Foundation
import CoreData


extension Jokes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Jokes> {
        return NSFetchRequest<Jokes>(entityName: "Jokes")
    }

    @NSManaged public var id: String?
    @NSManaged public var joke: String?
    @NSManaged public var status: Int64

}

extension Jokes : Identifiable {

}
