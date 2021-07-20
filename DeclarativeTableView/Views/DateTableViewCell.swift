//
//  DateTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class DateTableViewCell: UITableViewCell, Reusable, StateRepresentable {
    private var state = Date()

    func setState(_ state: Date, animated isAnimated: Bool) {
        textLabel?.text = DateFormatter.localizedString(from: state, dateStyle: .medium, timeStyle: .short)
        textLabel?.adjustsFontSizeToFitWidth = true
    }

}
