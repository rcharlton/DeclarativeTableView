//
//  DateTableViewCell.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import UIKit

class DateTableViewCell: UITableViewCell, Reusable, TypeDepending, ViewHeightProviding {
    static var viewHeight: CGFloat = 74

    func setDependency(_ dependency: Date) {
        contentView.backgroundColor = .systemTeal
        textLabel?.text = DateFormatter.localizedString(from: dependency, dateStyle: .medium, timeStyle: .short)
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}
