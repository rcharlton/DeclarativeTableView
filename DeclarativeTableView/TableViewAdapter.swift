//
//  TableViewAdapter.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

class TableViewAdapter: NSObject, UITableViewDataSource {

    var sections: [TableViewSectionProvider] = []

    func register(with tableView: UITableView) {
        tableView.dataSource = self
        sections.forEach { $0.register(with: tableView) }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].numberOfRows
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath) ?? MessageTableViewCell()
    }

}
