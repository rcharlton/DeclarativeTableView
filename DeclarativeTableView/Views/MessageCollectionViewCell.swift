//
//  MessageCollectionViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell, ViewHeightProviding, Reusable, TypeDependent {
    static var viewHeight: CGFloat = 50 // TODO: review how heights are generated

    private let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        contentView.backgroundColor = .systemPurple
        textLabel.frame = contentView.bounds
        contentView.addSubview(textLabel)
    }

    func setDependencies(_ dependencies: String) {
        textLabel.text = dependencies
    }
}
