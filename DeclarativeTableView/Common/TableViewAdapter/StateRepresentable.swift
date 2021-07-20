//
//  StateRepresentable.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

protocol StateRepresentable {
    associatedtype State
    func setState(_ state: State, animated isAnimated: Bool)
}

