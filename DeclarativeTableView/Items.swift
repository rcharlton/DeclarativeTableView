//
//  Items.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

struct HeaderItem {
    let state: (Int) -> (UIColor, String)
}

extension HeaderItem: TableViewRepresentable {
    func tableViewHeaderFooterViewProviderAt(_ indexPath: IndexPath) -> TableViewHeaderFooterViewProviding? {
        TableViewHeaderFooterViewProvider<MyHeaderFooterView>(state: state)
    }
}

typealias FooterItem = HeaderItem

struct NumberItem {
    let state: (IndexPath) -> Int
    let action: () -> Void
}

extension NumberItem: TableViewRepresentable {
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<NumberTableViewCell>(row: indexPath.row, state: state) { _ in action() }
    }
}

struct MessageItem {
    let state: (IndexPath) -> String
}

extension MessageItem: TableViewRepresentable {
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<MessageTableViewCell>(row: indexPath.row, state: state)
    }
}

struct DateItem {
    let state: (IndexPath) -> Foundation.Date
}

extension DateItem: TableViewRepresentable {
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<DateTableViewCell>(row: indexPath.row, state: state)
    }
}
