//
//  TableViewCellProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

struct TableViewCellProvider<Cell: ReusableTableViewCell & TypeDependent & ViewHeightProviding>: TableViewCellProviding {
    let rows: ClosedRange<Int>

    let dependencies: (IndexPath) -> Cell.Dependencies

    let action: (IndexPath) -> Void

    init(
        rows: ClosedRange<Int>,
        dependencies: @escaping (IndexPath) -> Cell.Dependencies,
        action: @escaping (IndexPath) -> Void = { _ in }
    ) {
        self.rows = rows
        self.dependencies = dependencies
        self.action = action
    }

    init(
        row: Int,
        dependencies: @escaping (IndexPath) -> Cell.Dependencies,
        action: @escaping (IndexPath) -> Void = { _ in }
    ) {
        self.init(rows: (row...row), dependencies: dependencies, action: action)
    }

    func register(with tableView: UITableView) {
        tableView.register(Cell.self)
    }

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: Cell.self, for: indexPath)
        cell.setDependencies(dependencies(indexPath))
        return cell
    }

    func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        Cell.viewHeight
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        action(indexPath)
    }

}

extension TableViewCellProvider where Cell.Dependencies == Void {
    init(rows: ClosedRange<Int>, action: @escaping (IndexPath) -> Void = { _ in }) {
        self.init(rows: rows, dependencies: { _ in () }, action: action)
    }

    init(row: Int, action: @escaping (IndexPath) -> Void = { _ in }) {
        self.init(row: row, dependencies: { _ in () }, action: action)
    }
}
