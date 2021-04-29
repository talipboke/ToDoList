//
//  HomeViewController.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import UIKit

internal protocol HomeViewControllerDelegate: class {
    func homeViewControllerEditItem(_ homeViewController: HomeViewController, item: TodoDto)
    func homeViewControllerAddNewItem(_ homeViewController: HomeViewController)
}

internal final class HomeViewController: UIViewController {
    
    private(set) internal lazy var homeView = HomeView()
    internal lazy var addNewButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(didTapAddNewButton))
    
    private var viewModel: HomeViewModel
    internal let dataSource: TodoListDataSource
    private lazy var listViewController = makeListViewController()
    internal weak var delegate: HomeViewControllerDelegate?
    
    internal init(viewModel: HomeViewModel, dataSource: TodoListDataSource) {
        self.viewModel = viewModel
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = addNewButton
        addControllers()
        navigationItem.title = AppConst.homeNavigationTitle.localize()
        fetchTodoList()
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    internal func fetchTodoList() {
        viewModel.fetch { [weak self] (todoList) in
            self?.reloadListView(todoList: todoList)
        } failure: { (error) in
            #warning("Handle Error")
        }
    }
}

private extension HomeViewController {
    func addControllers() {
        add(listViewController, to: homeView.listView)
    }
    
    func makeListViewController() -> ListViewController {
        self.dataSource.deleteButtonAction = { [weak self] index in
            self?.viewModel.delete(index: index, success: { [weak self] (todoList) in
                self?.reloadListView(todoList: todoList)
            }, failure: { (error) in
                #warning("Handle Error")
            })
        }
        let controller = ListViewController(dataSource: self.dataSource,
                                            delegate: self,
                                            style: .plain)
        controller.tableView.backgroundColor = .clear
        return controller
    }

    @objc
    func didTapAddNewButton() {
        self.delegate?.homeViewControllerAddNewItem(self)
    }
    
    func reloadListView(todoList: [TodoDto]) {
        self.dataSource.todoList = todoList
        self.listViewController.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.homeViewControllerEditItem(self, item: self.dataSource.todoList[indexPath.row])
    }
}
