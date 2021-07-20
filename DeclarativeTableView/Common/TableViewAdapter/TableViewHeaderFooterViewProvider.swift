//
//  TableViewHeaderFooterViewProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

struct TableViewHeaderFooterViewProvider<
    View: ReusableTableViewHeaderFooterView & TypeDepending & ViewHeightProviding
>: TableViewHeaderFooterViewProviding {
    let dependency: (Int) -> View.DependentType

    func register(with tableView: UITableView) {
        tableView.register(View.self)
    }

    func viewForSectionAt(_ section: Int, with tableView: UITableView) -> UITableViewHeaderFooterView? {
        let view = tableView.dequeueReusableHeaderFooterView(withType: View.self)
        view.setDependency(dependency(section))
        return view
    }

    func viewHeightForSectionAt(_ section: Int) -> CGFloat {
        View.viewHeight
    }
}
