//
//  TableViewHeaderFooterViewProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

struct TableViewHeaderFooterViewProvider<
    View: ReusableTableViewHeaderFooterView & TypeDependent & ViewHeightProviding
>: TableViewHeaderFooterViewProviding {
    let dependencies: (Int) -> View.Dependencies

    func register(with tableView: UITableView) {
        tableView.register(View.self)
    }

    func viewForSectionAt(_ section: Int, with tableView: UITableView) -> UITableViewHeaderFooterView? {
        let view = tableView.dequeueReusableHeaderFooterView(withType: View.self)
        view.setDependencies(dependencies(section))
        return view
    }

    func viewHeightForSectionAt(_ section: Int) -> CGFloat {
        View.viewHeight
    }
}
