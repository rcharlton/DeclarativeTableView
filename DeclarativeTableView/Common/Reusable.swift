//
//  Reusable.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: type(of: self))
    }
}
