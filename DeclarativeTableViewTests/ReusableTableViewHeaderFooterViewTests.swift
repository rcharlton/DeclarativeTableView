//
//  ReusableTableViewHeaderFooterViewTests.swift
//  DeclarativeTableViewTests
//
//  Created by Robin Charlton on 22/07/2021.
//

import UIKit
import XCTest
@testable import DeclarativeTableView

class ReusableTableViewHeaderFooterViewTests: XCTestCase {
    let tableView = UITableView()

    func testDequeueReusableHeaderFooterView_ViewIsRegisteredByType_DoesNotFatalError() {
        tableView.register(ReusableHeaderFooterView.self)
        _ = tableView.dequeueReusableHeaderFooterView(withType: ReusableHeaderFooterView.self)
    }

}

private class ReusableHeaderFooterView: UITableViewHeaderFooterView, Reusable {
}
