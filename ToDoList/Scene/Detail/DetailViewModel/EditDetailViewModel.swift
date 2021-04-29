//
//  EditDetailViewModel.swift
//  GetirTodo
//
//  Created by Talip Böke on 20.04.2021.
//

import UIKit

internal struct EditDetailViewModel: DetailViewModel {
    
    internal var todo: TodoDto
    private let database: DataBaseProtocol
    var saveButtonType: UIBarButtonItem.SystemItem = .edit
    
    init(todo: TodoDto,database: DataBaseProtocol) {
        self.todo = todo
        self.database = database
    }
    
    internal func save(success: @escaping () -> Void, failure: @escaping DataBaseProtocol.Failure) {
        do {
            try database.update(entity: todo)
            success()
        }catch {
            failure(error)
        }
    }
}
