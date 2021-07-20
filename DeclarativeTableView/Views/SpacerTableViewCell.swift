//
//  SpacerTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

class SpacerTableViewCell: UITableViewCell, Reusable, TypeDepending, ViewHeightProviding {
    typealias DependentType = Void

    static var viewHeight: CGFloat = 8

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        contentView.backgroundColor = .lightGray
    }
}
