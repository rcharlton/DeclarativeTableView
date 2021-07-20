//
//  WarningCollectionViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

class WarningCollectionViewCell: UICollectionViewCell, Reusable, TypeDepending, ViewHeightProviding {
    typealias DependentType = Void
    static var viewHeight: CGFloat = 50

    init(at indexPath: IndexPath) {
        super.init(frame: .zero)

        let textLabel = configure(UILabel()) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "Failed to instantiate a cell for section \(indexPath.section), row \(indexPath.row)."
            $0.adjustsFontSizeToFitWidth = true
        }

        contentView.addSubview(textLabel)

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
