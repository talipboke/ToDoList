//
//  AppCoordinatorTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 19.04.2021.
//

import XCTest
@testable import GetirTodo

class AppCoordinatorTests: XCTestCase {

    var sut: AppCoordinator!
   
    override func setUp() {
        super.setUp()
        
        let mockDependencies = MockAppDependencies()
        let navigationController = MockNavigationController()
        MockProvider.createRouteWindowAndMakeVisible(navigationController)
        sut = mockDependencies.makeAppCoordinator(navigationController)
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldStartHomeCoordinator() {
        //When
        sut.start()
        
        //Then
        XCTAssertTrue(sut.childCoordinators.first is HomeCoordinator)
    }
}
