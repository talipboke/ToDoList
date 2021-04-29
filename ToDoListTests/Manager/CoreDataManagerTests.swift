//
//  CoreDataManagerTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 19.04.2021.
//

import XCTest
@testable import GetirTodo
import CoreData

class CoreDataManagerTests: XCTestCase {

    var sut: CoreDataManager!
    var mockItem: TodoDto!
    var mockDbItem: Todo!
    
    override func setUp() {
        super.setUp()
        sut = CoreDataManager.init(storeType: .inMemory)
        mockItem = MockProvider.createMockTodo()
    }
    
    override func tearDown() {
        sut = nil
        mockItem = nil
        mockDbItem = nil
        super.tearDown()
    }
    
    func test_ShouldFetchAll() {
        //Given
        try! sut.insert(entity: mockItem)
        try! sut.insert(entity: mockItem)
        
        //When
        let items = try! sut.fetchAll(dbEntity: Todo.self)
        
        //Then
        XCTAssertEqual(items.count, 2)
    }
    
    func test_ShouldInsertItem() {
        //Given
        var items = [TodoDto]()
        items = try! sut.fetchAll(dbEntity: Todo.self)
        XCTAssertEqual(items.count, 0)
        
        //When
        try! sut.insert(entity: mockItem)
    
        //Then
        items = try! sut.fetchAll(dbEntity: Todo.self)
        XCTAssertEqual(items.count, 1)
    }

    func test_ShouldDeleteItem() {
        //Given
        try! sut.insert(entity: mockItem)
        let item = try! sut.fetchAll(dbEntity: Todo.self)[0]

        //When
        try! sut.delete(entity: item)

        //XCT
        XCTAssertEqual(try! sut.fetchAll(dbEntity: Todo.self).count, 0)
    }
    
    func test_ShouldUpdateItem() {
        //Given
        try! sut.insert(entity: mockItem)
        let item = try! sut.fetchAll(dbEntity: Todo.self)[0]
        let updatedItem = TodoDto(dbId: item.dbId,title: "Başlık 2", content: "İçerik 1")
        
        //When
        try! sut.update(entity: updatedItem)
        
        //Then
        let newItem = try! sut.fetchAll(dbEntity: Todo.self)[0]
        XCTAssertEqual(newItem.title, updatedItem.title)
        XCTAssertEqual(newItem.content, updatedItem.content)
    }
}
