//
//  DeclarativeTableViewTests.swift
//  DeclarativeTableViewTests
//
//  Created by Robin Charlton on 22/07/2021.
//

import UIKit
import XCTest
@testable import DeclarativeTableView

class ReusableTableViewCellTests: XCTestCase {
    let tableView = UITableView()

    func testDequeueReusableCell_CellIsRegisteredByType_DoesNotFatalError() {
        tableView.register(ReusableCell.self)
        _ = tableView.dequeueReusableCell(withType: ReusableCell.self, for: IndexPath(row: 0, section: 0))
    }

}

private class ReusableCell: UITableViewCell, Reusable {
}
