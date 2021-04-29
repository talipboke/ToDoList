//
//  HomeCoordinator.swift
//  GetirTodo
//
//  Created by Talip Böke on 19.04.2021.
//

import UIKit

internal class HomeCoordinator: CoordinatorProtocol {
    
    typealias Factory = HomeViewControllerBuilder &
                        DetailViewControllerBuilder
    
    var childCoordinators: [CoordinatorProtocol] = []
    internal var navigationController: UINavigationController
    private let factory: Factory
    
    internal init(navigationController: UINavigationController,
                  factory: Factory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        showHomeViewController()
    }
}

private extension HomeCoordinator{
    func showHomeViewController() {
        let homeViewController: HomeViewController = factory.build()
        homeViewController.delegate = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func show(_ detailViewController: DetailViewController, homeViewController: HomeViewController) {
        detailViewController.saveCompleted = { [weak self] in
            homeViewController.fetchTodoList()
            self?.navigationController.popViewController(animated: true)
        }
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func showEditDetailViewController(todo: TodoDto,homeViewController: HomeViewController) {
        let detailViewController: DetailViewController = factory.buildForEdit(todo: todo)
        show(detailViewController, homeViewController: homeViewController)
    }
    
    func showAddNewDetailViewController(homeViewController: HomeViewController) {
        let detailViewController: DetailViewController = factory.buildForAdd()
        show(detailViewController, homeViewController: homeViewController)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewControllerEditItem(_ homeViewController: HomeViewController, item: TodoDto) {
        showEditDetailViewController(todo: item, homeViewController: homeViewController)
    }
    
    func homeViewControllerAddNewItem(_ homeViewController: HomeViewController) {
        showAddNewDetailViewController(homeViewController: homeViewController)
    }
}
