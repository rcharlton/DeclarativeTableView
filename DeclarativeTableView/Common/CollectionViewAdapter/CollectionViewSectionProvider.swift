//
//  CollectionViewSectionProvider.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

protocol CollectionViewCellProviding {
    var rows: ClosedRange<Int> { get }

    func register(with collectionView: UICollectionView)

    func cellForItemAt(_ indexPath: IndexPath, with collectionView: UICollectionView) -> UICollectionViewCell

    func didSelectItemAt(_ indexPath: IndexPath)
}

protocol CollectionViewSectionProviding {
    var numberOfItems: Int { get }

    func register(with collectionView: UICollectionView)

    func cellForItemAt(_ indexPath: IndexPath, with collectionView: UICollectionView) -> UICollectionViewCell?

    func didSelectItemAt(_ indexPath: IndexPath)
}


struct CollectionViewSectionProvider: CollectionViewSectionProviding {
    let cellProviders: [CollectionViewCellProviding]

    var numberOfItems: Int {
        cellProviders.reduce(0) { $0 + $1.rows.count }
    }

    func register(with collectionView: UICollectionView) {
        cellProviders.forEach { $0.register(with: collectionView) }
    }

    func cellForItemAt(_ indexPath: IndexPath, with collectionView: UICollectionView) -> UICollectionViewCell? {
        cellProviders
            .first { $0.rows.contains(indexPath.row) }
            .map { $0.cellForItemAt(indexPath, with: collectionView) }
    }

    func didSelectItemAt(_ indexPath: IndexPath) {
        let cellProvider = cellProviders.first { $0.rows.contains(indexPath.row) }
        cellProvider?.didSelectItemAt(indexPath)
    }
}
