//
//  MessageTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell, Reusable, StateRepresentable, ViewHeightProviding {
    static var viewHeight: CGFloat = 50

    func setState(_ state: String, animated isAnimated: Bool) {
        textLabel?.text = state
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}
