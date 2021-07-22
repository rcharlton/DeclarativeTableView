//
//  ReusableTableViewHeaderFooterView.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 22/07/2021.
//

import UIKit

typealias ReusableTableViewHeaderFooterView = UITableViewHeaderFooterView & Reusable

extension UITableView {
    func register<T: ReusableTableViewHeaderFooterView>(_: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableHeaderFooterView<T: ReusableTableViewHeaderFooterView>(withType type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier) as? T else {
            fatalError("Failed to dequeue header-footer view: \(type.reuseIdentifier)")
        }
        return view
    }
}
