//
//  PopularManager.swift
//  DiplomSF
//
//  Created by Алексей on 02.09.2025.
//

import Foundation
import CoreData

final class PopularManager: PopularManagerProtocol {
    // MARK: – Container
    private let container: NSPersistentContainer
    
    // MARK: – Initializate
    init(container: NSPersistentContainer) {
        self.container = container
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
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
    
    func fetch<T>(of type: T.Type, sortDescriptors: [NSSortDescriptor]? = nil, completion: @escaping (Result<[T], Error>) -> Void) where T : NSManagedObject {
        let fetchRequest = Popular.fetchRequest()
        fetchRequest.sortDescriptors = sortDescriptors
        
        container.performBackgroundTask { context in
            do {
                let object = try context.fetch(fetchRequest)
                let objectsID = object.map { $0.objectID }
                
                DispatchQueue.main.async {
                    let mainContextObjects: [T] = objectsID.compactMap {
                        self.container.viewContext.object(with: $0) as? T
                    }
                    DispatchQueue.main.async {
                        completion(.success(mainContextObjects))
                    }
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func update<T: NSManagedObject>(of type: T.Type, with id: Int, on changes: [PopularUpdateEnum], completion: @escaping () -> Void) {
        container.performBackgroundTask { context in
            let fetchRequest = Popular.fetchRequest()
            let predicate = NSPredicate(format: "id == %id", id)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = predicate
            
            do {
                guard let object = try context.fetch(fetchRequest).first else { return }
                changes.forEach { $0.apply(object) }
                try context.save()
                DispatchQueue.main.async {
                    completion()
                }
            } catch let error as NSError {
                print("Ошибка обновления данных: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    // Разделить на fetch одного элемента и нескольких
    // Понять куда вшить обновления и как оптимизировать обновление одного элемента и нескольких
    // Обновление должно происходить каждый раз при первой загрузке (то есть в презентере при else fetch)
    // Также обновление должно происходить, когда будем проваливаться в карточку фильма, тогда возможно у нас будет время на фоновое обновление и последующую main загрузку
    // Если загрузка будет проходить долго, то нужно добавить loader
    // В UI добавить название каждого из разделов по HUG (Популярно / Боевики / Экшен и тд)
    
}

enum PopularUpdateEnum {
    case originalTitle(String)
    case posterPath(String)
    case releaseDate(String)
    case overview(String)
    case voteAverage(Double)
    case backdropPath(String)
    
    var apply: (Popular) -> Void {
        switch self {
        case .backdropPath(let value):
            return { $0.backdropPath = value }
        case .originalTitle(let value):
            return { $0.originalTitle = value }
        case .overview(let value):
            return { $0.overview = value }
        case .posterPath(let value):
            return { $0.posterPath = value }
        case .releaseDate(let value):
            return { $0.releaseDate = value }
        case .voteAverage(let value):
            return { $0.voteAverage = value }
        }
    }
}
