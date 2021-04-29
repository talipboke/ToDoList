//
//  EditDetailViewModelTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 21.04.2021.
//

import XCTest
@testable import GetirTodo

class EditDetailViewModelTests: XCTestCase {
    var sut: EditDetailViewModel!
    var database: DataBaseProtocol!

    override func setUp() {
        super.setUp()
        let mockDependencies = MockAppDependencies()
        database = mockDependencies.database
    }
    
    override func tearDown() {
        sut = nil
        database = nil
        super.tearDown()
    }
    
    func test_ShouldUpdateTodo() {
        //Given
        try! database.insert(entity: MockProvider.createMockTodo())
        let item = try! database.fetchAll(dbEntity: Todo.self).first!
        sut = EditDetailViewModel.init(todo: item, database: database)
        let updateExpectation = expectation(description: "Update Expectation")
        
        let newTitle = "new title"
        let newContent = "new content"
    
        sut.todo.title = newTitle
        sut.todo.content = newContent
        
        //When
        sut.save { 
            updateExpectation.fulfill()
        } failure: { (error) in }
        
        wait(for: [updateExpectation], timeout: 3.0)
        
        //Then
        let expectedItem = try! database.fetchAll(dbEntity: Todo.self).first!
        XCTAssertEqual(newTitle, expectedItem.title)
        XCTAssertEqual(newContent, expectedItem.content)
    }
}
