//
//  Component.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

enum Component {
    case header(state: (Int) -> (UIColor, String))
    case footer(state: (Int) -> (UIColor, String))
    case number(state: (IndexPath) -> Int)
    case message(state: (IndexPath) -> String)
    case date(state: (IndexPath) -> Date)
}

extension Component: TableViewRepresentable {
    func asTableViewHeaderFooterViewProvider(indexPath: IndexPath) -> TableViewHeaderFooterViewProviding? {
        switch self {
        case let .header(state),
             let .footer(state):
            return TableViewHeaderFooterViewProvider<MyHeaderFooterView>(state: state)
        case .number,
             .message,
             .date:
            return nil
        }
    }

    func asTableViewCellProvider(indexPath: IndexPath) -> TableViewCellProviding? {
        switch self {
        case .header,
             .footer:
            return nil
        case let .number(state):
            return TableViewCellProvider<NumberTableViewCell>(row: indexPath.row, state: state)
        case .message(state: let state):
            return TableViewCellProvider<MessageTableViewCell>(row: indexPath.row, state: state)
        case .date(state: let state):
            return TableViewCellProvider<DateTableViewCell>(row: indexPath.row, state: state)
        }
    }
}

// MARK: -

protocol TableViewRepresentable {
    func asTableViewHeaderFooterViewProvider(indexPath: IndexPath) -> TableViewHeaderFooterViewProviding?

    func asTableViewCellProvider(indexPath: IndexPath) -> TableViewCellProviding?
}

extension Array where Element: TableViewRepresentable {
    func asTableViewSectionProviders() -> [TableViewSectionProviding] {
        var sections: [TableViewSectionProviding] = []
        var header: TableViewHeaderFooterViewProviding?
        var cells: [TableViewCellProviding] = []

        for component in self {
            let indexPath = IndexPath(row: cells.count, section: sections.count)

            if let incomingHeaderOrFooter = component.asTableViewHeaderFooterViewProvider(indexPath: indexPath) {
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

            if let incomingCell = component.asTableViewCellProvider(indexPath: indexPath) {
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
