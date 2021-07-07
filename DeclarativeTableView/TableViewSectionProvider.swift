//
//  TableViewSectionProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

protocol TableViewHeaderFooterViewProviding {
    var viewHeight: CGFloat { get }

    func register(with tableView: UITableView)

    func view(with tableView: UITableView) -> UITableViewHeaderFooterView?
}

protocol TableViewCellProviding {
    var rows: ClosedRange<Int> { get }

    func register(with tableView: UITableView)

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell
}

protocol TableViewSectionProviding {
    var numberOfRows: Int { get }

    var headerViewHeight: CGFloat { get }

    var footerViewHeight: CGFloat { get }

    func register(with tableView: UITableView)

    func headerView(with tableView: UITableView) -> UIView?

    func footerView(with tableView: UITableView) -> UIView?

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell?
}

struct TableViewSectionProvider: TableViewSectionProviding {
    let headerViewProvider: TableViewHeaderFooterViewProviding?

    let footerViewProvider: TableViewHeaderFooterViewProviding?

    let cellProviders: [TableViewCellProviding]

    var numberOfRows: Int {
        cellProviders.reduce(0) { $0 + $1.rows.count }
    }

    var headerViewHeight: CGFloat {
        headerViewProvider?.viewHeight ?? 0
    }

    var footerViewHeight: CGFloat {
        footerViewProvider?.viewHeight ?? 0
    }

    func register(with tableView: UITableView) {
        headerViewProvider?.register(with: tableView)
        cellProviders.forEach { $0.register(with: tableView) }
    }

    func headerView(with tableView: UITableView) -> UIView? {
        headerViewProvider?.view(with: tableView)
    }

    func footerView(with tableView: UITableView) -> UIView? {
        footerViewProvider?.view(with: tableView)
    }

    func cellForRowAt(_ indexPath: IndexPath, with tableView: UITableView) -> UITableViewCell? {
        cellProviders
            .first { $0.rows.contains(indexPath.row) }
            .map { $0.cellForRowAt(indexPath, with: tableView) }
    }
}
