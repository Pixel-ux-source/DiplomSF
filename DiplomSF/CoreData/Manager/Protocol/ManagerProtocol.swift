//
//  PopularFilmsManager.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    func create<T: MappableProtocol>(from dto: T, completion: @escaping (Result<[T.Entity], Error>) -> Void)
    func fetch<T: NSManagedObject>(of type: T.Type, sortDescriptors: [NSSortDescriptor]?, completion: @escaping (Result<[T], Error>) -> Void)
    func sync<T: IdentifiableDTO, E: NSManagedObject, U: UpdateEnumProtocol>(of entityType: E.Type, of updateType: U.Type, with dtos: [T], key: String, deleteMissing: Bool, updateBuilder: @escaping (E,T) -> [U], completion: @escaping (Result<Void, Error>) -> Void) where U.Entity == E
    func search<T: NSManagedObject>(of type: T.Type, with query: String, completion: @escaping (Result<[T], Error>) -> Void)
    
}
