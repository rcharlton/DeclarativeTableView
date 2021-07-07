//
//  ViewController.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import Bricolage
import UIKit

class ViewController: UIViewController {

    private let tableView = configure(UITableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let tableViewAdapter = configure(TableViewAdapter()) {
        $0.cellProviders = [
            [
                RowAdapter<MessageTableViewCell>(row: 0) { _ in "Hello" },
                RowAdapter<NumberTableViewCell>(rows: 1...3) { $0.row },
                RowAdapter<DateTableViewCell>(row: 4) { _ in Date().advanced(by: 24 * 60 * 60) }
            ]
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewAdapter.register(with: tableView)

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }

}

class TableViewAdapter: NSObject, UITableViewDataSource {

    var cellProviders: [[TableViewCellProviding]] = [[]]

    func register(with tableView: UITableView) {
        tableView.dataSource = self

        cellProviders
            .flatMap { $0 }
            .forEach { $0.register(with: tableView) }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellProviders[section].reduce(0) { $0 + $1.rows.count }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let provider = cellProviders[indexPath.section].first { $0.rows.contains(indexPath.row) }
        return provider?.tableView(tableView, cellForRowAt: indexPath) ?? MessageTableViewCell()
    }

}

protocol TableViewCellProviding {
    var rows: ClosedRange<Int> { get }
    func register(with tableView: UITableView)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

struct RowAdapter<TableViewCell: ReusableTableViewCell & StateRepresentable>: TableViewCellProviding {
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
