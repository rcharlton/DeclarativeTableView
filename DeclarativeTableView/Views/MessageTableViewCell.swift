//
//  MessageTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell, Reusable, TypeDepending, ViewHeightProviding {
    static var viewHeight: CGFloat = 50

    func setDependency(_ dependency: String) {
        contentView.backgroundColor = .systemPink
        textLabel?.text = dependency
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}
