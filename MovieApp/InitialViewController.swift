//
//  InitialViewController.swift
//  MovieApp
//
//  Created by FIVE on 10.04.2022..
//

import Foundation
import UIKit
import PureLayout

class InitialViewController: UIViewController {
    let cellIdentifier = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let tableView = UITableView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: view.bounds.height))
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier) // 1.
        tableView.dataSource = self // 2.
    }
}

extension InitialViewController: UITableViewDataSource { // 3.
    func numberOfSections(in tableView: UITableView) -> Int {
return 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) // 4.
        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration() // 5.
        cellConfig.text = "Row \(indexPath.row)"
        cellConfig.textProperties.color = .blue
        cell.contentConfiguration = cellConfig
return cell }
}
