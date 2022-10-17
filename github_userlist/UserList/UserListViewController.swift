//
//  UserListViewController.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit

class UserListTableViewController: UITableViewController {
    static let cellIdentifier = "Cell"
    var userList = [User]()
    let network = Network()
    
    override func viewDidLoad() {
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        
        Task {
            guard let userList = try? await network.userList() else { return }
            self.userList = userList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension UserListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        if let cell = cell as? UserListTableViewCell, indexPath.row < userList.count {
            cell.style(model: userList[indexPath.row])
        }
        return cell
    }
}
