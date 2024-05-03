//
//  CoreDataService.swift
//  Weather_App
//
//  Created by ho.bao.an on 03/05/2024.
//

import Foundation
import CoreData
import RxSwift

final class CoreDataService {
    static let shared = CoreDataService()
    private let disposeBag = DisposeBag()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetchEntities<T: NSManagedObject>(predicate: NSPredicate? = nil) -> Observable<[T]> {
        return Observable.create { observer in
            let context = self.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
            fetchRequest.predicate = predicate
            
            do {
                let results = try context.fetch(fetchRequest)
                observer.onNext(results)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func saveEntity<T: NSManagedObject>(entity: T) -> Observable<Void> {
        let context = self.persistentContainer.viewContext
        return Observable.create { observer in
            do {
                try context.save()
                observer.onNext(())
                observer.onCompleted()
                print("Entity saved successfully")
            } catch {
                observer.onError(error)
                print("Failed to save entity: \(error)")
            }
            return Disposables.create()
        }
    }
    
    func deleteEntity<T: NSManagedObject>(entity: T) -> Observable<Void> {
        let context = self.persistentContainer.viewContext
        return Observable.create { observer in
            context.delete(entity)
            do {
                try context.save()
                observer.onNext(())
                observer.onCompleted()
                print("Entity deleted successfully")
            } catch {
                observer.onError(error)
                print("Failed to delete entity: \(error)")
            }
            return Disposables.create()
        }
    }
}
