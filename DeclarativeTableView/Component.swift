//
//  Component.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
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

    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        TableViewCellProvider<NumberTableViewCell>(row: indexPath.row, state: state)
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

// MARK: -

protocol TableViewRepresentable {
    func tableViewHeaderFooterViewProviderAt(_ indexPath: IndexPath) -> TableViewHeaderFooterViewProviding?
    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding?
}

extension TableViewRepresentable {
    func tableViewHeaderFooterViewProviderAt(_ indexPath: IndexPath) -> TableViewHeaderFooterViewProviding? {
        nil
    }

    func tableViewCellProviderAt(_ indexPath: IndexPath) -> TableViewCellProviding? {
        nil
    }
}

extension Array where Element == TableViewRepresentable {
    var tableViewSectionProviders: [TableViewSectionProviding] {
        var sections: [TableViewSectionProviding] = []
        var header: TableViewHeaderFooterViewProviding?
        var cells: [TableViewCellProviding] = []

        for component in self {
            let indexPath = IndexPath(row: cells.count, section: sections.count)

            if let incomingHeaderOrFooter = component.tableViewHeaderFooterViewProviderAt(indexPath) {
                if header == nil && cells.isEmpty {
                    header = incomingHeaderOrFooter
                } else {
                    sections.append(
                        TableViewSectionProvider(
                            headerViewProvider: header,
                            footerViewProvider: incomingHeaderOrFooter,
                            cellProviders: cells
                        )
                    )
                    header = nil
                    cells = []
                }
            }

            if let incomingCell = component.tableViewCellProviderAt(indexPath) {
                cells.append(incomingCell)
            }
        }

        if header != nil || !cells.isEmpty {
            sections.append(
                TableViewSectionProvider(
                    headerViewProvider: header,
                    footerViewProvider: nil,
                    cellProviders: cells
                )
            )
        }

        return sections
    }
}
