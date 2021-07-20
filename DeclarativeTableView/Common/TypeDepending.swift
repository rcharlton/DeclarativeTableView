//
//  TypeDepending.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 20/07/2021.
//

protocol TypeDepending {
    associatedtype DependentType
    func setDependency(_ dependency: DependentType)
}

extension TypeDepending where DependentType == Void {
    func setDependency(_ dependency: DependentType) {
    }
}
