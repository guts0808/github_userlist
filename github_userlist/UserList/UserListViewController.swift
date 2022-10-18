//
//  UserListViewController.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit

class UserListTableViewController: UITableViewController {
    static let cellIdentifier = "Cell"
    let interactor = UserListInteractor()
    let router = UserListRouter()
    
    override func viewDidLoad() {
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        
        Task {
            await interactor.loadData()
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
        return interactor.numberOfUser
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        if let cell = cell as? UserListTableViewCell,
            let user = interactor.user(at: indexPath.row) {
            cell.style(model: user)
        }
        return cell
    }
}

extension UserListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = interactor.user(at: indexPath.row) else { return }
        router.showUserDetail(with: user, fromViewController: self)
    }
}
