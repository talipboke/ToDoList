//
//  ReuseIdentifiableTests.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 18.04.2021.
//

import XCTest
@testable import GetirTodo

class ReuseIdentifiableTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_ShouldReturnTableViewCellNameForReuseIdentifier() {
        // Given
        let cellClassName = String(describing: UITableViewCell.self)

        // Then
        XCTAssertEqual(UITableViewCell.reuseIdentifier, cellClassName)
    }

    func test_ShouldReturnTableViewHeaderFooterViewNameForReuseIdentifier() {
        // Given
        let cellClassName = String(describing: MockTableViewHeaderFooterView.self)

        // Then
        XCTAssertEqual(MockTableViewHeaderFooterView.reuseIdentifier, cellClassName)
    }

    // Test stubs

    class MockTableViewCell: UITableViewCell {}

    class MockTableViewHeaderFooterView: UITableViewHeaderFooterView {}
}
