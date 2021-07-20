//
//  CollectionViewCellProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

struct CollectionViewCellProvider<Cell: ReusableCollectionViewCell & TypeDepending>: CollectionViewCellProviding {
    let rows: ClosedRange<Int>

    let dependency: (IndexPath) -> Cell.DependentType

    let action: (IndexPath) -> Void

    init(
        rows: ClosedRange<Int>,
        dependency: @escaping (IndexPath) -> Cell.DependentType,
        action: @escaping (IndexPath) -> Void = { _ in }
    ) {
        self.rows = rows
        self.dependency = dependency
        self.action = action
    }

    init(
        row: Int,
        dependency: @escaping (IndexPath) -> Cell.DependentType,
        action: @escaping (IndexPath) -> Void = { _ in }
    ) {
        self.init(rows: (row...row), dependency: dependency, action: action)
    }

    func register(with collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }

    func cellForItemAt(_ indexPath: IndexPath, with collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: Cell.self, for: indexPath)
        cell.setDependency(dependency(indexPath))
        return cell
    }

    func didSelectItemAt(_ indexPath: IndexPath) {
        action(indexPath)
    }

}

extension CollectionViewCellProvider where Cell.DependentType == Void {
    init(rows: ClosedRange<Int>, action: @escaping (IndexPath) -> Void = { _ in }) {
        self.init(rows: rows, dependency: { _ in () }, action: action)
    }

    init(row: Int, action: @escaping (IndexPath) -> Void = { _ in }) {
        self.init(row: row, dependency: { _ in () }, action: action)
    }
}
