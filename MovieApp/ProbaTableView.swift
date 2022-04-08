//
//  ProbaTableView.swift
//  MovieApp
//
//  Created by FIVE on 08.04.2022..
//

import Foundation
import UIKit
import PureLayout

class ProbaTableView: UIViewController {
    var moviesUITableView: UITableView!
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        buildViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews() {
        moviesUITableView = UITableView(
            frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        )
         view.addSubview(moviesUITableView)
        
        moviesUITableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        moviesUITableView.dataSource = self
    }
    
    func addConstraints() {
        moviesUITableView.autoPinEdgesToSuperviewEdges()
    }
}

extension ProbaTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration()
        cellConfig.text = "Row \(indexPath.row)"
        cellConfig.textProperties.color = .systemGreen
        
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
