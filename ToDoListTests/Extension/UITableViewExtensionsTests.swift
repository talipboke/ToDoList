//
//  UITableViewExtensionsTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 18.04.2021.
//

import XCTest
@testable import GetirTodo

class UITableViewTests: XCTestCase {

    var sut: UITableView!

    override func setUp() {
        super.setUp()
        sut = UITableView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_ShouldDequeueCell() {
        // Given
        sut.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        let indexPath = IndexPath(row: 0, section: 0)

        // When
        let cell = sut.dequeueReusableCell(withClass: UITableViewCell.self, for: indexPath)

        //Then
        XCTAssertNotNil(cell)
    }

    func test_ShouldDequeuHeaderFooterView() {
        // Given
        sut.register(MockHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: MockHeaderFooterView.reuseIdentifier)

        // When
        let headerFooterView = sut.dequeueReusableHeaderFooterView(withClass: MockHeaderFooterView.self)

        //Then
        XCTAssertNotNil(headerFooterView)
    }

    class MockHeaderFooterView: UITableViewHeaderFooterView {}

}

