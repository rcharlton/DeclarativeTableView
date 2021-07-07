//
//  TableViewHeaderFooterViewProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

struct TableViewHeaderFooterViewProvider<View: ReusableTableViewHeaderFooterView & StateRepresentable>: TableViewHeaderFooterViewProviding {
    private(set) var viewHeight: CGFloat

    let state: () -> View.State

    func register(with tableView: UITableView) {
        tableView.register(View.self)
    }

    func view(with tableView: UITableView) -> UITableViewHeaderFooterView? {
        let view = tableView.dequeueReusableHeaderFooterView(withType: View.self)
        view.setState(state(), animated: false)
        return view
    }

}
