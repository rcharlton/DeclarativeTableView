//
//  DateTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class DateTableViewCell: UITableViewCell, Reusable, TypeDependent, ViewHeightProviding {
    static var viewHeight: CGFloat = 74

    func setDependencies(_ dependencies: Date) {
        contentView.backgroundColor = .systemTeal
        textLabel?.text = DateFormatter.localizedString(from: dependencies, dateStyle: .medium, timeStyle: .short)
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}
