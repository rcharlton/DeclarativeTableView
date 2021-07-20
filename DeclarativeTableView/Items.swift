//
//  Items.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

struct HeaderItem: TableViewRepresentable {
    let state: (Int) -> (UIColor, String)

    func tableViewHeaderFooterViewProviderAt(_ indexPath: IndexPath) -> TableViewHeaderFooterViewProviding? {
        TableViewHeaderFooterViewProvider<MyHeaderFooterView>(state: state)
    }
}

typealias FooterItem = HeaderItem

struct NumberItem: TableViewRepresentable {
    let state: (IndexPath) -> Int
    let action: () -> Void

    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<NumberTableViewCell>(row: indexPath.row, state: state) { _ in action() }
    }
}

struct MessageItem: TableViewRepresentable {
    let state: (IndexPath) -> String

    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<MessageTableViewCell>(row: indexPath.row, state: state)
    }
}

struct DateItem: TableViewRepresentable {
    let state: (IndexPath) -> Foundation.Date

    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<DateTableViewCell>(row: indexPath.row, state: state)
    }
}
