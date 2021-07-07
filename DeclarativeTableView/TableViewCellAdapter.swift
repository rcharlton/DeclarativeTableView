//
//  TableViewCellProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

struct TableViewCellProvider<TableViewCell: ReusableTableViewCell & StateRepresentable>: TableViewCellProviding {
    let rows: ClosedRange<Int>
    let state: (IndexPath) -> TableViewCell.State

    init(rows: ClosedRange<Int>, state: @escaping (IndexPath) -> TableViewCell.State) {
        self.rows = rows
        self.state = state
    }

    init(row: Int, state: @escaping (IndexPath) -> TableViewCell.State) {
        self.init(rows: (row...row), state: state)
    }

    func register(with tableView: UITableView) {
        tableView.register(TableViewCell.self)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: TableViewCell.self, for: indexPath)
        cell.setState(state(indexPath), animated: false)
        return cell
    }
}
