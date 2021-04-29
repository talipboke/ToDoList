//
//  HomeViewControllerTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 18.04.2021.
//

import XCTest
@testable import GetirTodo

class HomeViewControllerTests: XCTestCase {

    var sut: HomeViewController!
    var dataBase: DataBaseProtocol!
    
    override func setUp() {
        super.setUp()
        dataBase = CoreDataManager(storeType: .inMemory)
        let viewModel = HomeViewModel(database: dataBase)
        let todoList = [TodoDto.init(title: "Başlık 1", content: "İçerik 1"),
                        TodoDto.init(title: "Başlık 2", content: "İçerik 2")]
        sut = HomeViewController.init(viewModel: viewModel,
                                      dataSource: TodoListDataSource.init(todoList: todoList))
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldAddViewControllers() {
        //When
        _ = sut.view
        
        //Then
        XCTAssertTrue(sut.children.first is ListViewController)
    }
    
    func test_ShouldBindInitialProperties() {
        //When
        _ = sut.view
        
        //Then
        XCTAssertEqual(sut.navigationItem.title, AppConst.homeNavigationTitle.localize())
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem, sut.addNewButton)
    }
    
    func test_ShouldFetchDataFromDB() {
        //Given
        try! dataBase.insert(entity: TodoDto.init(title: "Başlık 1", content: "İçerik 1"))
        
        //When
        _ = sut.view
        
        //Then
        XCTAssertEqual(sut.dataSource.todoList.count, 1)
    }
    
    func test_ShouldCallEditItemWhenTappedRowInTableView() {
        //Given
        let delegate = MockHomeViewControllerDelegate()
        sut.delegate = delegate
        let tableView = UITableView()
        let indexPath = IndexPath(row:0, section: 0)
        
        //When
        sut.tableView(tableView, didSelectRowAt: indexPath)
        
        //Then
        XCTAssertTrue(delegate.didCallEditItem)
    }
   
    func test_ShouldCallAddNewItemWhenTappedRightBarButtonItem() {
        //Given
        let delegate = MockHomeViewControllerDelegate()
        sut.delegate = delegate
        _ = sut.view
        
        //When
        UIApplication.shared.sendAction(sut.addNewButton.action!, to: sut.addNewButton.target, from: nil, for: nil)
    
        //Then
        XCTAssertTrue(delegate.didCallAddNewItem)
    }
}
