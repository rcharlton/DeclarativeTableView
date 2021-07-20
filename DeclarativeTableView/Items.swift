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
        TableViewHeaderFooterViewProvider<MyHeaderFooterView>(dependencies: state)
    }
}

typealias FooterItem = HeaderItem

struct NumberItem {
    let state: (IndexPath) -> Int
    let action: () -> Void
}

extension NumberItem: TableViewRepresentable {
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<NumberTableViewCell>(row: indexPath.row, dependencies: state) { _ in action() }
    }
}

struct MessageItem {
    let state: (IndexPath) -> String
}

extension MessageItem: TableViewRepresentable {
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<MessageTableViewCell>(row: indexPath.row, dependencies: state)
    }
}

extension MessageItem: CollectionViewRepresentable {
    func collectionViewCellProviderAt(_ indexPath: IndexPath) -> CollectionViewCellProviding? {
        CollectionViewCellProvider<MessageCollectionViewCell>(row: indexPath.row, dependencies: state)
    }
}

struct DateItem {
    let state: (IndexPath) -> Foundation.Date
}

extension DateItem: TableViewRepresentable {
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<DateTableViewCell>(row: indexPath.row, dependencies: state)
    }
}

struct SpacerItem {
}

extension SpacerItem: TableViewRepresentable {
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<SpacerTableViewCell>(row: indexPath.row)
    }
}

struct CarouselItem {
    let contents: (IndexPath) -> [CollectionViewRepresentable]
}

extension CarouselItem: TableViewRepresentable {
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<CarouselTableViewCell>(row: indexPath.row, dependencies: contents)
    }
}
