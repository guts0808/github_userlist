//
//  UserDetailTableViewController.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit

class UserDetailTableViewController: UITableViewController {
    static let cellIdentifier = "Cell"
    static let headerIdentifier = "Header"
    
    var userDetail: UserDetail?
    var repositories = [Repository]()
    let userName: String
    let network = Network()

    init(userDetail: UserDetail? = nil, repositories: [Repository] = [Repository](), userName: String) {
        self.userDetail = userDetail
        self.repositories = repositories
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        tableView.register(UserDetailTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: Self.headerIdentifier)
        
        Task {
            self.userDetail = try await network.user(userName: userName)
            self.repositories = try await network.repositories(userName: userName) ?? [Repository]()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
 
}

// MARK: - Table view data source
extension UserDetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        if let cell = cell as? UserDetailTableViewCell, indexPath.row < repositories.count {
            cell.style(repository: repositories[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.headerIdentifier)
        if let headerView = headerView as? UserDetailTableViewHeaderView,
           let userDetail = userDetail {
            headerView.style(userDetail: userDetail)
        }
        return headerView
    }
}
