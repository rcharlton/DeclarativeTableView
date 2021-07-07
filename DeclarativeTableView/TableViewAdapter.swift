//
//  TableViewAdapter.swift
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

class TableViewAdapter: NSObject, UITableViewDataSource {

    var cellProviders: [[TableViewCellProviding]] = [[]]

    func register(with tableView: UITableView) {
        tableView.dataSource = self

        cellProviders
            .flatMap { $0 }
            .forEach { $0.register(with: tableView) }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        cellProviders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellProviders[section].reduce(0) { $0 + $1.rows.count }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let provider = cellProviders[indexPath.section].first { $0.rows.contains(indexPath.row) }
        return provider?.tableView(tableView, cellForRowAt: indexPath) ?? MessageTableViewCell()
    }

}
