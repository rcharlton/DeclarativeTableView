//
//  TableViewCellProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

struct TableViewCellProvider<Cell: ReusableTableViewCell & StateRepresentable>: TableViewCellProviding {
    let rows: ClosedRange<Int>
    
    let state: (IndexPath) -> Cell.State

    init(rows: ClosedRange<Int>, state: @escaping (IndexPath) -> Cell.State) {
        self.rows = rows
        self.state = state
    }

    init(row: Int, state: @escaping (IndexPath) -> Cell.State) {
        self.init(rows: (row...row), state: state)
    }

    func register(with tableView: UITableView) {
        tableView.register(Cell.self)
    }

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: Cell.self, for: indexPath)
        cell.setState(state(indexPath), animated: false)
        return cell
    }
}
