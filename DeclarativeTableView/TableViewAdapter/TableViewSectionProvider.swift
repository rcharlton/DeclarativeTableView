//
//  TableViewSectionProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

protocol TableViewHeaderFooterViewProviding {
    func register(with tableView: UITableView)

    func viewForSectionAt(_ section: Int, with tableView: UITableView) -> UITableViewHeaderFooterView?

    func viewHeightForSectionAt(_ section: Int) -> CGFloat
}

protocol TableViewCellProviding {
    var rows: ClosedRange<Int> { get }

    func register(with tableView: UITableView)

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell

    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol TableViewSectionProviding {
    var numberOfRows: Int { get }

    func register(with tableView: UITableView)

    func headerViewForSectionAt(_ section: Int, with tableView: UITableView) -> UIView?

    func headerViewHeightForSectionAt(_ section: Int) -> CGFloat

    func footerViewForSectionAt(_ section: Int, with tableView: UITableView) -> UIView?

    func footerViewHeightForSectionAt(_ section: Int) -> CGFloat

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell?

    func didSelectRowAt(_ indexPath: IndexPath)
}

struct TableViewSectionProvider: TableViewSectionProviding {
    let headerViewProvider: TableViewHeaderFooterViewProviding?

    let footerViewProvider: TableViewHeaderFooterViewProviding?

    let cellProviders: [TableViewCellProviding]

    var numberOfRows: Int {
        cellProviders.reduce(0) { $0 + $1.rows.count }
    }

    func register(with tableView: UITableView) {
        headerViewProvider?.register(with: tableView)
        footerViewProvider?.register(with: tableView)
        cellProviders.forEach { $0.register(with: tableView) }
    }

    func headerViewForSectionAt(_ section: Int, with tableView: UITableView) -> UIView? {
        headerViewProvider?.viewForSectionAt(section, with: tableView)
    }

    func headerViewHeightForSectionAt(_ section: Int) -> CGFloat {
        headerViewProvider?.viewHeightForSectionAt(section) ?? 0
    }

    func footerViewForSectionAt(_ section: Int, with tableView: UITableView) -> UIView? {
        footerViewProvider?.viewForSectionAt(section, with: tableView)
    }

    func footerViewHeightForSectionAt(_ section: Int) -> CGFloat {
        footerViewProvider?.viewHeightForSectionAt(section) ?? 0
    }

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell? {
        cellProviders
            .first { $0.rows.contains(indexPath.row) }
            .map { $0.cellForRowAt(indexPath, with: tableView) }
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        let cellProvider = cellProviders.first { $0.rows.contains(indexPath.row) }
        cellProvider?.didSelectRowAt(indexPath)
    }
}
