//
//  PopularFilmsManager.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import CoreData

protocol PopularManagerProtocol: AnyObject {
    func create<T: MappableProtocol>(from dto: T, completion: @escaping (Result<[T.Entity], Error>) -> Void)
    func fetch<T: NSManagedObject>(of type: T.Type, sortDescriptors: [NSSortDescriptor]?, completion: @escaping (Result<[T], Error>) -> Void)
}
