//
//  AddNewDetailViewModelTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 21.04.2021.
//

import XCTest
@testable import GetirTodo

class AddNewDetailViewModelTests: XCTestCase {

    var sut: AddNewDetailViewModel!
    var database: DataBaseProtocol!
    var mockItem: TodoDto!
    
    override func setUp() {
        super.setUp()
        let mockDependencies = MockAppDependencies()
        database = mockDependencies.database
        sut = AddNewDetailViewModel.init(database: database)
        mockItem = MockProvider.createMockTodo()
    }
    
    override func tearDown() {
        sut = nil
        database = nil
        mockItem = nil
        super.tearDown()
    }
    
    func test_ShouldInsertNewItem() {
        //Given
        let insertExpectation = expectation(description: "Insert Expectation")
        
        //When
        sut.save {
            insertExpectation.fulfill()
        } failure: { (error) in }

        wait(for: [insertExpectation], timeout: 1.0)
        
        XCTAssertEqual(try! database.fetchAll(dbEntity: Todo.self).count, 1)
    }

}
