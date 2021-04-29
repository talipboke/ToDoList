//
//  DetailViewModel.swift
//  GetirTodo
//
//  Created by Talip Böke on 21.04.2021.
//

import UIKit

internal protocol DetailViewModel {
    var todo: TodoDto { get set}
    func save(success: @escaping () -> Void, failure: @escaping DataBaseProtocol.Failure)
    var saveButtonType: UIBarButtonItem.SystemItem {get}
}
