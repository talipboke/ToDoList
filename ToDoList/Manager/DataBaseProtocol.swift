//
//  DataBaseProtocol.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import Foundation
import CoreData

protocol DbEntity {
    
    var dbId: NSManagedObjectID {get set}
    
    func insertToDb(container: NSPersistentContainer)
    func updateInDb(container: NSPersistentContainer)
}
