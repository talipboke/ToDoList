//
//  HomeViewControllerBuilder.swift
//  GetirTodo
//
//  Created by Talip Böke on 19.04.2021.
//

import Foundation

internal protocol HomeViewControllerBuilder {
    func build() -> HomeViewController
}

extension AppDependencies: HomeViewControllerBuilder {
    func build() -> HomeViewController {
        let viewModel = HomeViewModel(database: database)
        let dataSource = TodoListDataSource(todoList: [])
        return HomeViewController.init(viewModel: viewModel,
                                       dataSource: dataSource)
    }
}
