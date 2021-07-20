//
//  MyHeaderFooterView.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

class MyHeaderFooterView: UITableViewHeaderFooterView, Reusable, TypeDepending, ViewHeightProviding {
    static var viewHeight: CGFloat = 80

    private let label = configure(UILabel()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 18, weight: .medium)
    }

    func setDependency(_ dependency: (UIColor, String)) {
        contentView.backgroundColor = dependency.0
        label.text = dependency.1
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
