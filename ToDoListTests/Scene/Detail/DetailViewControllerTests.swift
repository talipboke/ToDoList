//
//  DetailViewControllerTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 21.04.2021.
//

import XCTest
@testable import GetirTodo

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    var mockItem: TodoDto!
    
    override func setUp() {
        super.setUp()
        let dependencies = MockAppDependencies()
        mockItem = MockProvider.createMockTodo()
        sut = dependencies.buildForEdit(todo: mockItem)
    }
    
    override func tearDown() {
        sut = nil
        mockItem = nil
        super.tearDown()
    }
    
    func test_ShouldBind() {
        //When
        _ = sut.view

        //Then
        XCTAssertEqual(sut.detailView.titleTextField.text, mockItem.title)
        XCTAssertEqual(sut.detailView.contentTextView.text, mockItem.content)
    }
    
    func test_ShouldBindRightBarButton() {
        //When
        _ = sut.view
        
        //Then
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem, sut.saveButton)
    }
    
    func test_ShouldCallSaveCompleted() {
        //Given
        let dependencies = MockAppDependencies()
        let database = dependencies.database
        
        try! database.insert(entity: mockItem)
        let item = try! database.fetchAll(dbEntity: Todo.self).first!
    
        let viewModel = EditDetailViewModel.init(todo: item, database: database)
        sut = DetailViewController.init(viewModel: viewModel)
        _ = sut.view
        sut.detailView.titleTextField.text = "title 1"
        sut.detailView.contentTextView.text = "content 1"
        var called = false
        sut.saveCompleted = {
            called = true
        }
        
        //When
        UIApplication.shared.sendAction(sut.saveButton.action!, to: sut.saveButton.target, from: nil, for: nil)
        
        //Then
        XCTAssertTrue(called)
    }
}
