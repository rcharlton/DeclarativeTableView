//
//  NumberTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class NumberTableViewCell: UITableViewCell, Reusable, TypeDepending, ViewHeightProviding {
    static var viewHeight: CGFloat = 40

    func setDependency(_ dependency: Int) {
        contentView.backgroundColor = .systemYellow
        textLabel?.text = "The number is \(dependency)"
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}
