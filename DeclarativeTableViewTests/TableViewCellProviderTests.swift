//
// TableViewCellProviderTests.swift
// DeclarativeTableViewTests
//
// Created by Robin Charlton on 22/07/2021.
//

import UIKit
import XCTest
@testable import DeclarativeTableView

class TableViewCellProviderTests: XCTestCase {
    let tableView = UITableView()

    func testInitialize_Parameters_RowsIsCorrect() {
        let range = (3...6)
        let cellProvider = TableViewCellProvider<ReusableVoidCell>(rows: range)
        XCTAssertEqual(cellProvider.rows, range)
    }

    func testInitialize_Parameters_DependencyIsCorrect() {
        let value = "DEPENDENCY"
        let cellProvider = TableViewCellProvider<ReusableStringCell>(row: 0) { _ in value }
        XCTAssertEqual(cellProvider.dependency(IndexPath()), value)
    }

    func testCellForRowAt_TableViewIsRegisteredWithCellProvider_CellTypeIsCorrect() {
        let cellProvider = TableViewCellProvider<ReusableVoidCell>(row: 0)
        cellProvider.register(with: tableView)

        let cell = cellProvider.cellForRowAt(IndexPath(), with: tableView)

        XCTAssertNotNil(cell as? ReusableVoidCell)
    }

    func testCellForRowAt_TableViewIsRegisteredWithCellProvider_DependencyIsCorrectlyAssigned() {
        let value = "DEPENDENCY"
        let cellProvider = TableViewCellProvider<ReusableStringCell>(row: 0) { _ in value }
        cellProvider.register(with: tableView)

        let cell = cellProvider.cellForRowAt(IndexPath(), with: tableView)

        XCTAssertEqual((cell as? ReusableStringCell)?.dependency, value)
    }

    func testHeightForRowAt_IndexPath_ViewHeightIsCorrect() {
        let cellProvider = TableViewCellProvider<ReusableVoidCell>(row: 0)
        let height = cellProvider.heightForRowAt(IndexPath())
        XCTAssertEqual(height, ReusableVoidCell.viewHeight)
    }

    func testDidSelectRowAt_IndexPath_ActionIsInvokedWithCorrectIndexPath() {
        var invokedIndexPath: IndexPath?
        let cellProvider = TableViewCellProvider<ReusableVoidCell>(
            row: 0,
            action: { invokedIndexPath = $0 }
        )

        let indexPath = IndexPath(row: 123, section: 456)
        cellProvider.didSelectRowAt(indexPath)

        XCTAssertEqual(invokedIndexPath, indexPath)
    }

}

private typealias ReusableVoidCell = ReusableCell<Void>
private typealias ReusableStringCell = ReusableCell<String>

private class ReusableCell<DependentType>: UITableViewCell, Reusable, TypeDepending, ViewHeightProviding {
    var dependency: DependentType?

    func setDependency(_ dependency: DependentType) {
        self.dependency = dependency
    }

    static var viewHeight: CGFloat { 123 }
}
