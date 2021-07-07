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
                TableViewRowAdapter<MessageTableViewCell>(row: 0) { _ in "Hello" },
                TableViewRowAdapter<NumberTableViewCell>(rows: 1...3) { $0.row },
                TableViewRowAdapter<DateTableViewCell>(row: 4) { _ in Date().advanced(by: 24 * 60 * 60) }
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
