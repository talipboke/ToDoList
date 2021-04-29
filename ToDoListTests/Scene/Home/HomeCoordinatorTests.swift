//
//  HomeCoordinatorTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 20.04.2021.
//

import XCTest
@testable import GetirTodo

class HomeCoordinatorTests: XCTestCase {

    var sut: HomeCoordinator!

    override func setUp() {
        super.setUp()
        
        let mockDependencies = MockAppDependencies()
        let navigationController = MockNavigationController()
        MockProvider.createRouteWindowAndMakeVisible(navigationController)
        sut = mockDependencies.makeHomeCoodinator(navigationController)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldShowHomeViewController() {
        //When
        sut.start()
        
        //Then
        XCTAssertTrue(sut.navigationController.viewControllers.last is HomeViewController)
    }
    
    func test_ShouldShowDetailViewControllerWhenInvokedEditItem() {
        //Given
        let item = MockProvider.createMockTodo()
        let homeViewController: HomeViewController = MockAppDependencies().build()
        
        //When
        sut.homeViewControllerEditItem(homeViewController, item: item)
        
        //Then
        XCTAssertTrue(sut.navigationController.viewControllers.last is DetailViewController)
    }
    
    func test_ShouldShowDetailViewControllerWhenInvokedAddNewItem() {
        //Given
        let homeViewController: HomeViewController = MockAppDependencies().build()
        
        //When
        sut.homeViewControllerAddNewItem(homeViewController)
        
        //Then
        XCTAssertTrue(sut.navigationController.viewControllers.last is DetailViewController)
    }
    
//    func test_ShouldShowDetailViewControllerWhenDidTapCall() {
//        //Given
//        let model = MockProvider.createBaseModel()
//        let homeViewController = MockAppDependencies().build()
//        
//        //When
//        sut.homeViewControllerDidTapCell(homeViewController, model: model)
//        
//        //Then
//        XCTAssertTrue(sut.navigationController.viewControllers.last is DetailViewController)
//    }
}
