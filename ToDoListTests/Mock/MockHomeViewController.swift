//
//  MockHomeViewController.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 20.04.2021.
//

import UIKit
@testable import GetirTodo

class MockHomeViewControllerDelegate: HomeViewControllerDelegate {
    private(set) var didCallEditItem = false
    private(set) var didCallAddNewItem = false
    
    func homeViewControllerEditItem(_ homeViewController: HomeViewController, item: TodoDto) {
        didCallEditItem = true
    }
    
    func homeViewControllerAddNewItem(_ homeViewController: HomeViewController) {
        didCallAddNewItem = true
    }
}
