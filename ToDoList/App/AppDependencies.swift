//
//  AppDependencies.swift
//  GetirTodo
//
//  Created by Talip Böke on 19.04.2021.
//

import UIKit

internal struct AppDependencies {
    internal let database: DataBaseProtocol
    
    init(database: DataBaseProtocol = CoreDataManager(storeType: .disc)) {
        self.database = database
    }
}

internal protocol ConsumableDependencyFactoryProtocol {
    //func makeAPIClient() -> APIClientProtocol
}

extension AppDependencies: ConsumableDependencyFactoryProtocol {
//    func makeAPIClient() -> APIClientProtocol{
//        return APIClient()
//    }
}

internal protocol CoordinatorFactoryProtocol {
    func makeAppCoordinator(_ navigationController: UINavigationController) -> AppCoordinator
    func makeHomeCoodinator(_ navigationController: UINavigationController) -> HomeCoordinator
}

extension AppDependencies: CoordinatorFactoryProtocol {
    internal func makeAppCoordinator(_ navigationController: UINavigationController) -> AppCoordinator {
        return AppCoordinator(navigationController: navigationController,
                              factory: self)
    }
    
    internal func makeHomeCoodinator(_ navigationController: UINavigationController) -> HomeCoordinator {
        return HomeCoordinator(navigationController: navigationController,
                               factory: self)
    }
}
