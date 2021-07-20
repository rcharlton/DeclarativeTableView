//
//  TableViewCellProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

struct TableViewCellProvider<Cell: ReusableTableViewCell & TypeDepending & ViewHeightProviding>: TableViewCellProviding {
    let rows: ClosedRange<Int>

    let dependency: (IndexPath) -> Cell.DependentType

    let action: (IndexPath) -> Void

    init(
        rows: ClosedRange<Int>,
        dependency: @escaping (IndexPath) -> Cell.DependentType,
        action: @escaping (IndexPath) -> Void = { _ in }
    ) {
        self.rows = rows
        self.dependency = dependency
        self.action = action
    }

    init(
        row: Int,
        dependency: @escaping (IndexPath) -> Cell.DependentType,
        action: @escaping (IndexPath) -> Void = { _ in }
    ) {
        self.init(rows: (row...row), dependency: dependency, action: action)
    }

    func register(with tableView: UITableView) {
        tableView.register(Cell.self)
    }

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: Cell.self, for: indexPath)
        cell.setDependency(dependency(indexPath))
        return cell
    }

    func heightForRowAt(_ indexPath: IndexPath) -> CGFloat {
        Cell.viewHeight
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        action(indexPath)
    }

}

extension TableViewCellProvider where Cell.DependentType == Void {
    init(rows: ClosedRange<Int>, action: @escaping (IndexPath) -> Void = { _ in }) {
        self.init(rows: rows, dependency: { _ in () }, action: action)
    }

    init(row: Int, action: @escaping (IndexPath) -> Void = { _ in }) {
        self.init(row: row, dependency: { _ in () }, action: action)
    }
}
