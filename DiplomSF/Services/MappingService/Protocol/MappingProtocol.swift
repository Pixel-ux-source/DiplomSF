//
//  MappingProtocol.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import CoreData

protocol MappingProtocol {
    associatedtype Entity: NSManagedObject
    associatedtype DTO: Decodable
    
    static func map(from dto: DTO, context: NSManagedObjectContext) -> [Entity]
}
