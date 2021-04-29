//
//  AppCoordinator.swift
//  GetirTodo
//
//  Created by Talip Böke on 19.04.2021.
//

import UIKit

internal protocol CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] {get set}
    func start()
    var navigationController: UINavigationController {get set}
}

internal class AppCoordinator: CoordinatorProtocol {
    
    internal typealias Factory = CoordinatorFactoryProtocol & ConsumableDependencyFactoryProtocol
    var childCoordinators: [CoordinatorProtocol] = []
    internal var navigationController: UINavigationController
    private let factory: Factory
    
    init(navigationController: UINavigationController,
         factory: Factory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        startHomeCoordinator()
    }
}

private extension AppCoordinator {
    func startHomeCoordinator() {
        let homeCoordinator = factory.makeHomeCoodinator(navigationController)
        childCoordinators.removeAll()
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
