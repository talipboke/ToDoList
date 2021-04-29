//
//  HomeViewModelTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 20.04.2021.
//

import XCTest
@testable import GetirTodo

class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    var database: DataBaseProtocol!
    var mockItem: TodoDto!
    
    override func setUp() {
        super.setUp()
        let mockDependencies = MockAppDependencies()
        database = mockDependencies.database
        sut = HomeViewModel.init(database: database)
        mockItem = MockProvider.createMockTodo()
    }

    override func tearDown() {
        sut = nil
        database = nil
        mockItem = nil
        super.tearDown()
    }
    
    func test_ShouldFetchTodoList() {
        //Given
        try! database.insert(entity: mockItem)
        let fetchExpectation = expectation(description: "Fetch Expectation")
        var expectedTodo: TodoDto?
        //When
        sut.fetch { (todoList) in
            expectedTodo = todoList.first
            fetchExpectation.fulfill()
        } failure: { (error) in }
        
        wait(for: [fetchExpectation], timeout: 1.0)
        XCTAssertEqual(expectedTodo?.title, mockItem.title)
        XCTAssertEqual(expectedTodo?.content, mockItem.content)
    }

    func test_ShouldDeleteTodoAndReturnList() {
        //Given
        try! database.insert(entity: mockItem)
        try! database.insert(entity: mockItem)
        let deleteExpectation = expectation(description: "Delete Expectation")
        var todoList = [TodoDto]()
        
        sut.fetch(success: { (result) in
            todoList = result
        }, failure: {error in })
        sut.todoList = todoList
        
        //When
        sut.delete(index: 0) { (todoList) in
            deleteExpectation.fulfill()
        } failure: { (error) in }

        //Then
        wait(for: [deleteExpectation], timeout: 1.0)
        XCTAssertEqual(sut.todoList.count, 1)
        
    }
    
}
