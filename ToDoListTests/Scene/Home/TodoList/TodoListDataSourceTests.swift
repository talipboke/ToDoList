//
//  TodoListDataSourceTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 18.04.2021.
//

import XCTest
@testable import GetirTodo

class TodoListDataSourceTests: XCTestCase {

    var sut: TodoListDataSource!
    var tableView: UITableView!
    var mockItem: TodoDto!
    
    override func setUp() {
        super.setUp()
        mockItem = MockProvider.createMockTodo()
        sut = TodoListDataSource(todoList: [mockItem])
        tableView = UITableView()
    }
    
    override func tearDown() {
        sut = nil
        tableView = nil
        mockItem = nil
        super.tearDown()
    }
    
    func test_ShouldRegisterTitleTableCell() {
        //Given
        sut.registerCells(to: tableView)
        let indexPath = IndexPath(item: 0, section: 0)
        
        //When
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)
        
        //Then
        XCTAssertTrue(cell is TitleTableCell)
    }
    
    func test_ShouldNumberOfRowsShouldBeModelCount() {
        //Given
        var numberOfRowsInSection = sut.tableView(tableView, numberOfRowsInSection: 0)
        sut.todoList.append(mockItem)
        
        //When
        numberOfRowsInSection = sut.tableView(tableView, numberOfRowsInSection: 0)
        
        //Then
        XCTAssertEqual(numberOfRowsInSection, 2)
    }
    
    func test_ShouldConfigureCell() {
        //Given
        sut.registerCells(to: tableView)
        
        //When
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TitleTableCell
        
        //Then
        XCTAssertEqual(cell?.titleLabel.text, mockItem.title)
    }
}
