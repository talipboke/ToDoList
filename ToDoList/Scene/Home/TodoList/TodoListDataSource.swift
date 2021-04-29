//
//  TitleListDataSource.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import UIKit

internal final class TodoListDataSource: NSObject, ListViewDataSource {
    internal var todoList: [TodoDto]
    internal var deleteButtonAction: TitleTableCell.DeleteAction?
    
    internal init(todoList: [TodoDto]) {
        self.todoList = todoList
    }
    
    func registerCells(to tableView: UITableView) {
        tableView.register(TitleTableCell.self, forCellReuseIdentifier: TitleTableCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TitleTableCell.self, for: indexPath)
        cell.configure(title: todoList[indexPath.row].title, indexPath: indexPath)
        cell.deleteButtonAction = deleteButtonAction
        return cell
    }
}
