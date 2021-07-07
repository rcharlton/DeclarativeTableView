//
//  TableViewHeaderFooterViewProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

struct TableViewHeaderFooterViewProvider<View: ReusableTableViewHeaderFooterView & StateRepresentable>: TableViewHeaderFooterViewProviding {
    let viewHeight: CGFloat

    let state: (Int) -> View.State

    func register(with tableView: UITableView) {
        tableView.register(View.self)
    }

    func viewForSectionAt(_ section: Int, with tableView: UITableView) -> UITableViewHeaderFooterView? {
        let view = tableView.dequeueReusableHeaderFooterView(withType: View.self)
        view.setState(state(section), animated: false)
        return view
    }

    func viewHeightForSectionAt(_ section: Int) -> CGFloat {
        viewHeight
    }

}
