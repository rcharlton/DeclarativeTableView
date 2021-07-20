//
//  ViewController.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class ViewController: UIViewController {

    private let tableView = configure(UITableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private var exampleOfManualDeclarations: [TableViewSectionProviding] {
        [
            TableViewSectionProvider(
                headerViewProvider: TableViewHeaderFooterViewProvider<MyHeaderFooterView>{ (UIColor.orange, "Header for section \($0)") },
                footerViewProvider: TableViewHeaderFooterViewProvider<MyHeaderFooterView>{ (UIColor.gray, "Footer for section \($0)") },
                cellProviders: [
                    TableViewCellProvider<MessageTableViewCell>(row: 0) { _ in "Here are some number rows:" },
                    TableViewCellProvider<NumberTableViewCell>(rows: 1...20) { $0.row } action: { print("Action", $0) },
                    TableViewCellProvider<DateTableViewCell>(row: 21) { _ in Date() }
                ]
            ),
            TableViewSectionProvider(
                headerViewProvider: TableViewHeaderFooterViewProvider<MyHeaderFooterView>{ (UIColor.orange, "Header for section \($0)") },
                footerViewProvider: TableViewHeaderFooterViewProvider<MyHeaderFooterView>{ (UIColor.gray, "Footer for section \($0)") },
                cellProviders: [
                    TableViewCellProvider<MessageTableViewCell>(row: 0) { _ in "Another message cell" },
                    TableViewCellProvider<DateTableViewCell>(rows: 1...10) { Date().advanced(by: Double($0.row) * 24 * 60 * 60) }
                ]
            )
        ]
    }

    private var exampleOfComponentDeclarations: [TableViewSectionProviding] {
        [
            HeaderItem(state: { (UIColor.orange, "Header for section \($0)") }) as TableViewRepresentable,
            MessageItem(state: { _ in "Here are some number rows:" }),
            NumberItem { $0.row } action: { print("Do this") },
            NumberItem { $0.row } action: { print("Do that") },
            NumberItem { $0.row } action: { print("Do the other") },
            NumberItem { $0.row } action: { print("Do something") },
            NumberItem { $0.row } action: { print("Do something else") },
            DateItem(state: { _ in Date() }),
            FooterItem(state: { (UIColor.gray, "Footer for section \($0)") }),
            HeaderItem(state: { (UIColor.orange, "Header for section \($0)") }),
            MessageItem(state: { _ in "Another message cell" }),
            DateItem(state: { Date().advanced(by: Double($0.row) * 24 * 60 * 60) }),
            DateItem(state: { Date().advanced(by: Double($0.row) * 24 * 60 * 60) }),
            DateItem(state: { Date().advanced(by: Double($0.row) * 24 * 60 * 60) }),
        ].tableViewSectionProviders
    }

    private let tableViewAdapter = TableViewAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

//        tableViewAdapter.sections = exampleOfManualDeclarations
        tableViewAdapter.sections = exampleOfComponentDeclarations
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
