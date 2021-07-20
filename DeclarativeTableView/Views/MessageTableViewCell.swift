//
//  MessageTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell, Reusable, TypeDependent, ViewHeightProviding {
    static var viewHeight: CGFloat = 50

    func setDependencies(_ dependencies: String) {
        contentView.backgroundColor = .systemPink
        textLabel?.text = dependencies
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}
