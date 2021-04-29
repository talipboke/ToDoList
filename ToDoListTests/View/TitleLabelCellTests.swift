//
//  TitleLabelCellTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 18.04.2021.
//

import XCTest
@testable import GetirTodo

class TitleLabelCellTests: XCTestCase {

    var sut: TitleTableCell!
    
    override func setUp() {
        super.setUp()
        sut = TitleTableCell()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ShouldConfigure() {
        //Given
        let title = "Başlık 1"
        
        //When
        sut.configure(title: title, indexPath: IndexPath(row: 0, section: 0))
        
        //Then
        XCTAssertEqual(sut.titleLabel.text,title)
    }
    
    func test_ShouldCallDeleteButtonActionWhenDeleteButtonTapped() {
        //Given
        var called = false
        sut.configure(title: "Başlık 1", indexPath: IndexPath(row: 0, section: 0))
        sut.deleteButtonAction = { _ in
            called = true
        }
        
        //When
        sut.deleteButton.sendActions(for: .touchUpInside)
        
        //Then
        XCTAssertTrue(called)
    }
}
