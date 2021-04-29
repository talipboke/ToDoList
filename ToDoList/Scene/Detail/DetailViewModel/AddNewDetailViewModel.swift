//
//  AddNewDetailViewModel.swift
//  GetirTodo
//
//  Created by Talip Böke on 21.04.2021.
//

import UIKit

internal struct AddNewDetailViewModel: DetailViewModel {
    
    internal var todo = TodoDto(title: "", content: "")
    private let database: DataBaseProtocol
    var saveButtonType: UIBarButtonItem.SystemItem = .add
    
    internal init(database: DataBaseProtocol) {
        self.database = database
    }
    
    internal func save(success: @escaping () -> Void, failure: @escaping DataBaseProtocol.Failure) {
        do {
            try database.insert(entity: todo)
            success()
        }catch {
            failure(error)
        }
    }
}
