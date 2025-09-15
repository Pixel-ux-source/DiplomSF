//
//  MappableProtocol.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import CoreData

protocol MappableProtocol {
    associatedtype Entity: NSManagedObject
    func map(in context: NSManagedObjectContext) throws -> [Entity]
}
