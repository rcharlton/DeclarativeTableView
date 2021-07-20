//
//  CollectionViewAdapter.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

class CollectionViewAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var collectionView: UICollectionView? {
        didSet {
            guard let collectionView = self.collectionView else { return }
            register(with: collectionView)
        }
    }

    var sections: [CollectionViewSectionProviding] = [] {
        didSet {
            guard let collectionView = self.collectionView else { return }
            register(with: collectionView)
            collectionView.reloadData()
        }
    }

    private func register(with collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        sections.forEach { $0.register(with: collectionView) }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sections[indexPath.section].cellForItemAt(indexPath, with: collectionView)
            ?? WarningCollectionViewCell(at: indexPath)
    }
}
