//
//  ReusableCollectionViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

typealias ReusableCollectionViewCell = UICollectionViewCell & Reusable

extension UICollectionView {
    func register<T: ReusableCollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: ReusableCollectionViewCell>(
        withType type: T.Type,
        for indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell: \(type.reuseIdentifier)")
        }
        return cell
    }
}
