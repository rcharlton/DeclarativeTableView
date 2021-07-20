//
//  WarningTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

import UIKit

class WarningTableViewCell: UITableViewCell, Reusable, TypeDependent, ViewHeightProviding {
    typealias Dependencies = Void
    static var viewHeight: CGFloat = 50

    init(at indexPath: IndexPath) {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
        textLabel?.text = "Failed to instantiate a cell for section \(indexPath.section), row \(indexPath.row)."
        textLabel?.adjustsFontSizeToFitWidth = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
