//
//  TableViewRepresentable.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import Foundation

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

            if let cell = component.tableViewCellProviderAt(indexPath) {
                cells.append(cell)
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

extension TableViewAdapter {
    func setContents(_ contents: [TableViewRepresentable]) {
        self.sections = contents.tableViewSectionProviders
    }
}
