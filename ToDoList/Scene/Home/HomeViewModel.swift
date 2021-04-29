//
//  HomeViewModel.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import Foundation

internal struct HomeViewModel {
    private let database: DataBaseProtocol
    internal var todoList: [TodoDto] = []
    
    init(database: DataBaseProtocol) {
        self.database = database
    }
    
    internal mutating func fetch(success: @escaping DataBaseProtocol.Success, failure: DataBaseProtocol.Failure){
        do {
            let result = try database.fetchAll(dbEntity: Todo.self)
            todoList = result
            success(result)
        }catch {
            failure(error)
        }
    }
    
    internal mutating func delete(index: Int,success: @escaping DataBaseProtocol.Success, failure: DataBaseProtocol.Failure) {
        do {
            try database.delete(entity: todoList[index])
            fetch(success: success, failure: failure)
        }catch {
            failure(error)
        }
    }
}
