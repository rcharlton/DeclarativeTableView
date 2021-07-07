//
//  NumberTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class NumberTableViewCell: UITableViewCell, Reusable, StateRepresentable {
    private(set) var state: Int = 0

    func setState(_ state: Int, animated isAnimated: Bool) {
        textLabel?.text = "The number is \(state)"
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}
