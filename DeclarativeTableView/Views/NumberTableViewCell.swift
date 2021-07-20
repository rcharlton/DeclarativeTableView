//
//  NumberTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class NumberTableViewCell: UITableViewCell, Reusable, TypeDependent, ViewHeightProviding {
    static var viewHeight: CGFloat = 40

    func setDependencies(_ dependencies: Int) {
        contentView.backgroundColor = .systemYellow
        textLabel?.text = "The number is \(dependencies)"
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}
