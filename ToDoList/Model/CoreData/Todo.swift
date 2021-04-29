//
//  Todo+CoreDataClass.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//
//

import Foundation
import CoreData


public class Todo: NSManagedObject, Wrappable{
    typealias Wrapping = TodoDto
    @NSManaged public var title: String
    @NSManaged public var content: String
    
    func create() -> Wrapping {
        return TodoDto.init(dbId: self.objectID,
                            title: self.title,
                            content: self.content)
    }
    
    static func getEntityString() -> String {
        return "Todo"
    }
}

import Foundation
import CoreData

internal struct TodoDto: DbEntity{
    var dbId: NSManagedObjectID
  
    internal var title: String
    internal var content: String
    
    init(dbId: NSManagedObjectID = NSManagedObjectID(),
         title: String,
         content: String) {
        self.dbId = dbId
        self.title = title
        self.content = content
    }

    func insertToDb(container: NSPersistentContainer) {
        let object = Todo(context: container.viewContext)
        object.title = self.title
        object.content = self.content
    }
    
    func updateInDb(container: NSPersistentContainer) {
        let object = container.viewContext.object(with: dbId) as? Todo
        object?.title = self.title
        object?.content = self.content
    }
}
