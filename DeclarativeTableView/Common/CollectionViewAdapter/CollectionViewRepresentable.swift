//
//  CollectionViewRepresentable.swift
//  DeclarativeCollectionView
//
//  Created by Robin Charlton on 20/07/2021.
//

import Foundation

protocol CollectionViewRepresentable {
    func collectionViewCellProviderAt(_ indexPath: IndexPath) -> CollectionViewCellProviding?
}

extension Array where Element == CollectionViewRepresentable {
    // TODO: Add support for multiple sections.
    var collectionViewSectionProviders: [CollectionViewSectionProviding] {
        let cells = self.enumerated().compactMap {
            $1.collectionViewCellProviderAt(IndexPath(row: $0, section: 0))
        }
        return [CollectionViewSectionProvider(cellProviders: cells)]
    }
}

extension CollectionViewAdapter {
    func setContents(_ contents: [CollectionViewRepresentable]) {
        self.sections = contents.collectionViewSectionProviders
    }
}
