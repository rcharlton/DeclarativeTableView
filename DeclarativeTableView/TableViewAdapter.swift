//
//  TableViewAdapter.swift
//  DeclarativeTableView
//
//  Created by Robin Charlton on 07/07/2021.
//

import UIKit

class TableViewAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {

    var sections: [TableViewSectionProviding] = []

    func register(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        sections.forEach { $0.register(with: tableView) }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].numberOfRows
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        sections[section].headerView(with: tableView)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        sections[section].headerViewHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sections[indexPath.section].cellForRowAt(indexPath, with: tableView) ?? MessageTableViewCell()
    }

}
