//
//  AppConstTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 18.04.2021.
//

import XCTest
@testable import GetirTodo

class AppConstTests: XCTestCase {

    func test_ShouldLocalize() {
        //Given
        let title = AppConst.homeNavigationTitle
        let expectedString = "To-Do List :)"
        
        //When
        let localizedString = title.localize()
        
        //Then
        XCTAssertEqual(localizedString, expectedString)
    }
}
