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
        $0.sections = [
            TableViewSectionProvider(
                headerViewProvider: TableViewHeaderFooterViewProvider<MyHeaderFooterView>(viewHeight: 32){ (UIColor.orange, "First header") },
                footerViewProvider: TableViewHeaderFooterViewProvider<MyHeaderFooterView>(viewHeight: 64){ (UIColor.gray, "First footer") },
                cellProviders: [
                    TableViewCellProvider<MessageTableViewCell>(row: 0) { _ in "Here are some number rows:" },
                    TableViewCellProvider<NumberTableViewCell>(rows: 1...20) { $0.row },
                    TableViewCellProvider<DateTableViewCell>(row: 21) { _ in Date() }
                ]
            ),
            TableViewSectionProvider(
                headerViewProvider: TableViewHeaderFooterViewProvider<MyHeaderFooterView>(viewHeight: 64){ (UIColor.orange, "Second header") },
                footerViewProvider: TableViewHeaderFooterViewProvider<MyHeaderFooterView>(viewHeight: 64){ (UIColor.gray, "Second footer") },
                cellProviders: [
                    TableViewCellProvider<MessageTableViewCell>(row: 0) { _ in "Another message cell" },
                    TableViewCellProvider<DateTableViewCell>(rows: 1...10) { Date().advanced(by: Double($0.row) * 24 * 60 * 60) }
                ]
            )
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
