//
//  ViewController.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 06/07/2021.
//

import Bricolage
import UIKit

class ViewController: UIViewController {

    private let tableView = configure(UITableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(MessageTableViewCell.self)
    }
    private let tableViewAdapter = TableViewAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = tableViewAdapter

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }

}

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: type(of: self))
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(
        type: T.Type,
        for indexPath: IndexPath
    ) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell: \(T.reuseIdentifier)")
        }
        return cell
    }
}

//func tableView(
//    _ collectionView: UITableView,
//    cellForItemAt indexPath: IndexPath
//) -> UITableViewCell {
//    let cell: MyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
//    cell.configure(with: myData(for: indexPath))
//    return cell
//}


class MessageTableViewCell: UITableViewCell, Reusable {
    func configure(message: String) {
        textLabel?.text = message
        textLabel?.adjustsFontSizeToFitWidth = true
    }
}

class TableViewAdapter: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(type: MessageTableViewCell.self, for: indexPath)
        cell.configure(message: "Hello")
        return cell
    }

}
