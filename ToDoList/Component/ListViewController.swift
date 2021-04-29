//
//  ListViewController.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import UIKit

public class ListViewController: UIViewController {
    private(set) public lazy var tableView = makeTableView()
    private let dataSource: ListViewDataSource
    private weak var delegate: UITableViewDelegate?
    private let style: UITableView.Style
    
    public init(dataSource: ListViewDataSource, delegate: UITableViewDelegate? = nil, style: UITableView.Style = .plain) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public override func loadView() {
        super.loadView()
        view = tableView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

private extension ListViewController {
    func configureTableView() {
        dataSource.registerCells(to: tableView)
        tableView.dataSource = self.dataSource
        tableView.delegate = self.delegate
    }
    
    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .zero
        tableView.tableFooterView = UIView()
        return tableView
    }
}

public protocol ListViewDataSource: UITableViewDataSource {
    func registerCells(to tableView: UITableView)
}


