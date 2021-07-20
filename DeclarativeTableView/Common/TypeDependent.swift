//
//  TypeDependent.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

protocol TypeDependent {
    associatedtype Dependencies
    func setDependencies(_ dependencies: Dependencies)
}

extension TypeDependent where Dependencies == Void {
    func setDependencies(_ dependencies: Dependencies) {
    }
}
