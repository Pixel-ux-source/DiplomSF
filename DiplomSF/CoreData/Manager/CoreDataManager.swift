//
//  PopularManager.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import CoreData

protocol UpdateEnumProtocol {
    var apply: (Entity) -> Void { get }
    
    associatedtype Entity: NSManagedObject
}

final class CoreDataManager: CoreDataManagerProtocol {
    // MARK: – Container
    private let container: NSPersistentContainer
    
    // MARK: – Initializate
    init(container: NSPersistentContainer) {
        self.container = container
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: – Create
    func create<T>(from dto: T, completion: @escaping (Result<[T.Entity], any Error>) -> Void) where T : MappableProtocol {
        container.performBackgroundTask { context in
            do {
                let entities = try dto.map(in: context)
                try context.save()
                
                let objectsID = entities.map(\.objectID)
                DispatchQueue.main.async {
                    do {
                        let contextEntities = try objectsID.compactMap { objectID in
                            try self.container.viewContext.object(with: objectID) as? T.Entity
                        }
                        completion(.success(contextEntities))
                        print("✅ Successfully created event")
                    } catch let error as NSError {
                        completion(.failure(error))
                        print("Error: \(error) \n on line: \(#line)")
                    }
                }
            } catch let error as NSError {
                completion(.failure(error))
                print("Error: \(error) \n on line: \(#line)")
            }
        }
    }
    
    // MARK: – Read
    func fetch<T>(of type: T.Type, sortDescriptors: [NSSortDescriptor]? = nil, completion: @escaping (Result<[T], Error>) -> Void) where T : NSManagedObject {
        container.performBackgroundTask { context in
            let fetchRequest = T.fetchRequest()
            fetchRequest.sortDescriptors = sortDescriptors
            
            do {
                let object = try context.fetch(fetchRequest) as! [T]
                let objectsID = object.map { $0.objectID }
                
                DispatchQueue.main.async {
                    let mainContextObjects: [T] = objectsID.compactMap {
                        self.container.viewContext.object(with: $0) as? T
                    }
                    
                    completion(.success(mainContextObjects))
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    // MARK: – Update & Delete + Fetch
    func sync<T: IdentifiableDTO, E: NSManagedObject, U: UpdateEnumProtocol>(of entityType: E.Type, of updateType: U.Type, with dtos: [T], key: String = "id", deleteMissing: Bool = true, updateBuilder: @escaping (E,T) -> [U], completion: @escaping (Result<Void, Error>) -> Void) where U.Entity == E {
        container.performBackgroundTask { context in
            let serverIds = Set(dtos.map { Int64($0.id) })
            let fetchRequest = E.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "%K IN %@", key, Array(serverIds))
            
            do {
                let localObjects = try context.fetch(fetchRequest) as! [E]
                
                var localDict: [Int:E] = [:]
                for object in localObjects {
                    if let id = object.value(forKey: key) as? Int64 {
                        localDict[Int(id)] = object
                    }
                }
                
                for dto in dtos {
                    let entity: E
                    if let existing = localDict[dto.id] {
                        entity = existing
                    } else {
                        entity = E(context: context)
                        entity.setValue(dto.id, forKey: key)
                    }
                    
                    let updates = updateBuilder(entity, dto)
                    updates.forEach { $0.apply(entity) }
                }
                
                if deleteMissing {
                    let allRequest = E.fetchRequest()
                    let allLocal = try context.fetch(allRequest) as! [E]
                    
                    let grouping = Dictionary(grouping: allLocal) { object -> Int64 in
                        object.value(forKey: key) as? Int64 ?? 00
                    }
                    
                    for (id, objects) in grouping {
                        if serverIds.contains(id) {
                            for dupplicate in objects.dropFirst() {
                                context.delete(dupplicate)
                                print("Удален объект \(dupplicate)")
                            }
                        } else {
                            objects.forEach {
                                context.delete($0)
                                print("Удален объект \($0)")
                            }
                        }
                    }
                }
                
                try context.save()
                DispatchQueue.main.async {
                    completion(.success(()))
                }
                
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    // MARK: – Search Result
    func search<T: NSManagedObject>(of type: T.Type, with query: String, completion: @escaping (Result<[T], Error>) -> Void) {
        container.performBackgroundTask { context in
            let fetchRequest = T.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: true)]
            
            do {
                let object = try context.fetch(fetchRequest) as! [T]
                
                DispatchQueue.main.async {
                    let viewContext = self.container.viewContext
                    let model = object.compactMap { viewContext.object(with: $0.objectID) as? T }
                    completion(.success(model))
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    // Обновление должно происходить каждый раз при первой загрузке (то есть в презентере при else fetch)
    // Также обновление должно происходить, когда будем проваливаться в карточку фильма, тогда возможно у нас будет время на фоновое обновление и последующую main загрузку
    // Если загрузка будет проходить долго, то нужно добавить loader
    // В UI добавить название каждого из разделов по HUG (Популярно / Боевики / Экшен и тд)
    
}

enum FilmsUpdateEnum: UpdateEnumProtocol {
    typealias Entity = Popular
    
    case originalTitle(String)
    case posterPath(String)
    case releaseDate(String)
    case overview(String)
    case voteAverage(Double)
    case backdropPath(String)
    
    var apply: (Popular) -> Void {
        switch self {
        case .backdropPath(let value):
            return { if $0.backdropPath != value { $0.backdropPath = value } }
        case .originalTitle(let value):
            return { if $0.originalTitle != value { $0.originalTitle = value } }
        case .overview(let value):
            return { if $0.overview != value { $0.overview = value } }
        case .posterPath(let value):
            return { if $0.posterPath != value { $0.posterPath = value } }
        case .releaseDate(let value):
            return { if $0.releaseDate != value { $0.releaseDate = value } }
        case .voteAverage(let value):
            return { if $0.voteAverage != value { $0.voteAverage = value } }
        }
    }
}

