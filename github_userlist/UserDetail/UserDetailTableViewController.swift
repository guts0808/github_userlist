//
//  UserDetailTableViewController.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit

class UserDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UserDetailTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
 
}
