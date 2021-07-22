//
//  ReusableTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

typealias ReusableTableViewCell = UITableViewCell & Reusable

extension UITableView {
    func register<T: ReusableTableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: ReusableTableViewCell>(
        withType type: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell: \(type.reuseIdentifier)")
        }
        return cell
    }
}
