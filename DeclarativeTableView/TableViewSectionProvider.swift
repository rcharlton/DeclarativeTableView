//
//  TableViewSectionProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

protocol TableViewCellProviding {
    var rows: ClosedRange<Int> { get }

    func register(with tableView: UITableView)

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

struct TableViewSectionProvider {
    let section: Int

    let title: () -> String?

    let providers: [TableViewCellProviding]

    var numberOfRows: Int {
        providers.reduce(0) { $0 + $1.rows.count }
    }

    func register(with tableView: UITableView) {
        providers.forEach { $0.register(with: tableView) }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        providers
            .first { $0.rows.contains(indexPath.row) }
            .map { $0.tableView(tableView, cellForRowAt: indexPath) }
    }
}
