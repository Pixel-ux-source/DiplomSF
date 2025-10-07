//
//  Popular+CoreDataProperties.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//
//

import Foundation
import CoreData

@objc(Popular)
public class Popular: NSManagedObject { }

extension Popular {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Popular> {
        return NSFetchRequest<Popular>(entityName: "Popular")
    }

    @NSManaged public var id: Int64
    @NSManaged public var originalTitle: String?
    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var overview: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var backdropPath: String?

}

extension Popular : Identifiable { }
