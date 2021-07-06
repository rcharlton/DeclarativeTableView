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
        $0.register(MessageTableViewCell.self)
    }
    private let tableViewAdapter = TableViewAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = tableViewAdapter

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

    let cellProviders: [TableViewCellProviding] = [
        RowAdapter<MessageTableViewCell>(section: 0, rows: 0...9) { _ in "Hello world" }
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellProviders
            .filter { $0.section == section }
            .reduce(0) { $0 + $1.count }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let provider = cellProviders.first { $0.contains(indexPath: indexPath) }
        return provider?.tableView(tableView, cellForRowAt: indexPath) ?? MessageTableViewCell()
    }

}

protocol StateRepresentable {
    associatedtype State
    var state: State { get }
    func setState(_ state: State, animated isAnimated: Bool)
}

protocol TableViewCellProviding {
    var section: Int { get }
    var rows: ClosedRange<Int> { get }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

extension TableViewCellProviding {
    var count: Int {
        rows.count
    }

    func contains(indexPath: IndexPath) -> Bool {
        section == indexPath.section && rows.contains(indexPath.row)
    }
}

class RowAdapter<TableViewCell: UITableViewCell & Reusable & StateRepresentable>: TableViewCellProviding {
    let section: Int
    let rows: ClosedRange<Int>
    let state: (IndexPath) -> TableViewCell.State

    init(section: Int, rows: ClosedRange<Int>, state: @escaping (IndexPath) -> TableViewCell.State) {
        self.section = section
        self.rows = rows
        self.state = state
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: TableViewCell.self, for: indexPath)
        cell.setState(state(indexPath), animated: false)
        return cell
    }
}
