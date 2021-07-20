//
//  CarouselTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

class CarouselTableViewCell: UITableViewCell, Reusable, TypeDepending, ViewHeightProviding {
    static var viewHeight: CGFloat = 180

    private var state: [String] = []

    private static let layout = configure(UICollectionViewFlowLayout()) {
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 200, height: 150)
        $0.minimumLineSpacing = 10
    }

    private let collectionView = configure(
        UICollectionView(frame: .zero, collectionViewLayout: CarouselTableViewCell.layout)
    ) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .green
    }

    private let collectionViewAdapter = CollectionViewAdapter()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        collectionViewAdapter.collectionView = collectionView

        contentView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func setDependency(_ dependency: [CollectionViewRepresentable]) {
        collectionViewAdapter.setContents(dependency)
    }
}
