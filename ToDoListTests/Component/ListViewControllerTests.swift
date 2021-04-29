//
//  ListViewControllerTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 18.04.2021.
//

import XCTest
@testable import GetirTodo

class ListViewControllerTests: XCTestCase {

    var sut: ListViewController!
    var dataSource: MockDataSource!

    override func setUp() {
        super.setUp()
        dataSource = MockDataSource()
        sut = ListViewController(dataSource: dataSource)
    }
    
    override func tearDown() {
        sut = nil
        dataSource = nil
        super.tearDown()
    }
    
    func test_ShouldCallRegisterCellWhenControllerDidLoad() {
        //When
        XCTAssertFalse(dataSource.registerCellCalled)
        _ = sut.view
        
        //Then
        XCTAssertTrue(dataSource.registerCellCalled)
    }

    
    class MockDataSource: NSObject, ListViewDataSource {
        var registerCellCalled = false
        
        func registerCells(to tableView: UITableView) {
            registerCellCalled = true
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Test Content"
            return cell
        }
    }
}

