//
//  MyHeaderFooterView.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import Bricolage
import UIKit

class MyHeaderFooterView: UITableViewHeaderFooterView, Reusable, StateRepresentable, ViewHeightProviding {
    typealias State = (UIColor, String)

    private var state = (UIColor.gray, "")

    static var viewHeight: CGFloat = 64

    private let label = configure(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    func setState(_ state: State, animated isAnimated: Bool) {
        contentView.backgroundColor = state.0
        label.text = state.1
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: label.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }
}
