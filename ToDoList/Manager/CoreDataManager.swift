//
//  CoreDataManager.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import UIKit
import CoreData

enum CoreDataManagerError : Error{
    case fetching(errorDescription : String)
}

protocol DataBaseProtocol{
    typealias Success = ([TodoDto]) -> ()
    typealias Failure = (Error) -> Void
    func fetchAll<M : NSManagedObject & Wrappable>(dbEntity : M.Type) throws -> [M.Wrapping]
    func insert(entity: DbEntity) throws
    func delete(entity: DbEntity) throws
    func update(entity: DbEntity) throws
}

enum CoreDataNSPersistentStoreType{
    case disc
    case inMemory
    
    func getTypeString() -> String {
        switch self {
        case .disc:
            return NSSQLiteStoreType
        case .inMemory:
            return NSInMemoryStoreType
        }
    }
}

class CoreDataManager : DataBaseProtocol {
    // MARK: - Core Data stack
    private let containerName: String
    private let storeType: CoreDataNSPersistentStoreType
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        let description = container.persistentStoreDescriptions.first
        description?.type = storeType.getTypeString()
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    init(containerName: String = AppConfig.appName,storeType: CoreDataNSPersistentStoreType = .disc) {
        self.containerName = containerName
        self.storeType = storeType
    }
    
    func fetchAll<M : NSManagedObject & Wrappable>(dbEntity : M.Type) throws -> [M.Wrapping] {
            
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: dbEntity.getEntityString())
        var result = [M.Wrapping]()
        do {
            let records = try persistentContainer.viewContext.fetch(fetchRequest)
            if let records = records as? [M] {
                result = records.wrap()
            }
        } catch {
            throw CoreDataManagerError.fetching(errorDescription : error.localizedDescription)
        }
        return result
    }
    
    func insert(entity: DbEntity) throws{
        entity.insertToDb(container: persistentContainer)
        try saveContext()
    }
    
    func delete(entity: DbEntity) throws {
        let managedObject = persistentContainer.viewContext.object(with: entity.dbId)
        persistentContainer.viewContext.delete(managedObject)
        try saveContext()
    }
    
    func update(entity: DbEntity) throws{
        entity.updateInDb(container: persistentContainer)
        try saveContext()
    }
    
    // MARK: - Core Data Saving support
    private func saveContext () throws {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
               throw error
            }
        }
    }
}

//NSManagedObject ' i object ' e çevirmek için kullanılacak.
protocol Wrappable {
    associatedtype Wrapping
    func create() -> Wrapping
    static func getEntityString() -> String
}

extension Array where Element: Wrappable {
    func wrap() -> [Element.Wrapping] {
        return self.map {$0.create()}
    }
}








