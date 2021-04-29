//
//  MockAppDependencies.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 19.04.2021.
//

import UIKit
@testable import GetirTodo

class MockAppDependencies: ConsumableDependencyFactoryProtocol, CoordinatorFactoryProtocol {
    var database: DataBaseProtocol {
        return CoreDataManager(storeType: .inMemory)
    }
    
    func makeAppCoordinator(_ navigationController: UINavigationController) -> AppCoordinator {
        return AppCoordinator(navigationController: MockNavigationController(),
                              factory: self)
    }
    
    func makeHomeCoodinator(_ navigationController: UINavigationController) -> HomeCoordinator {
        return HomeCoordinator(navigationController: MockNavigationController(),
                               factory: self)
    }
}

extension MockAppDependencies: HomeViewControllerBuilder {
    func build() -> HomeViewController {
        let viewModel = HomeViewModel(database: database)
        return HomeViewController(viewModel: viewModel, dataSource: TodoListDataSource(todoList: []))
    }
}

extension MockAppDependencies: DetailViewControllerBuilder {
    func buildForEdit(todo: TodoDto) -> DetailViewController {
        let viewModel = EditDetailViewModel(todo: todo, database: database)
        return DetailViewController(viewModel: viewModel)
    }
    
    func buildForAdd() -> DetailViewController {
        let viewModel = AddNewDetailViewModel(database: database)
        return DetailViewController(viewModel: viewModel)
    }
}

