//
//  DetailViewControllerBuilder.swift
//  GetirTodo
//
//  Created by Talip Böke on 20.04.2021.
//

import Foundation

internal protocol DetailViewControllerBuilder {
    func buildForAdd() -> DetailViewController
    func buildForEdit(todo: TodoDto) -> DetailViewController
}

extension AppDependencies: DetailViewControllerBuilder {
    func buildForAdd() -> DetailViewController {
        let viewModel = AddNewDetailViewModel(database: database)
        return DetailViewController(viewModel: viewModel)
    }
    
    func buildForEdit(todo: TodoDto) -> DetailViewController {
        let viewModel = EditDetailViewModel(todo: todo, database: database)
        return DetailViewController(viewModel: viewModel)
    }
}
