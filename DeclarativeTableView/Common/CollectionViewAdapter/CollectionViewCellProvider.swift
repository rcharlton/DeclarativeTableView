//
//  CollectionViewCellProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

struct CollectionViewCellProvider<Cell: ReusableCollectionViewCell & TypeDependent>: CollectionViewCellProviding {
    let rows: ClosedRange<Int>

    let dependencies: (IndexPath) -> Cell.Dependencies

    let action: (IndexPath) -> Void

    init(
        rows: ClosedRange<Int>,
        dependencies: @escaping (IndexPath) -> Cell.Dependencies,
        action: @escaping (IndexPath) -> Void = { _ in }
    ) {
        self.rows = rows
        self.dependencies = dependencies
        self.action = action
    }

    init(
        row: Int,
        dependencies: @escaping (IndexPath) -> Cell.Dependencies,
        action: @escaping (IndexPath) -> Void = { _ in }
    ) {
        self.init(rows: (row...row), dependencies: dependencies, action: action)
    }

    func register(with collectionView: UICollectionView) {
        collectionView.register(Cell.self)
    }

    func cellForItemAt(_ indexPath: IndexPath, with collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withType: Cell.self, for: indexPath)
        cell.setDependencies(dependencies(indexPath))
        return cell
    }

    func didSelectItemAt(_ indexPath: IndexPath) {
        action(indexPath)
    }

}

extension CollectionViewCellProvider where Cell.Dependencies == Void {
    init(rows: ClosedRange<Int>, action: @escaping (IndexPath) -> Void = { _ in }) {
        self.init(rows: rows, dependencies: { _ in () }, action: action)
    }

    init(row: Int, action: @escaping (IndexPath) -> Void = { _ in }) {
        self.init(row: row, dependencies: { _ in () }, action: action)
    }
}
