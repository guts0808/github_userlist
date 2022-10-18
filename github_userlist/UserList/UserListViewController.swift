//
//  UserListViewController.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit
import SkeletonView

class UserListTableViewController: UITableViewController, SkeletonTableViewDataSource {
    static let cellIdentifier = "Cell"
    let interactor = UserListInteractor()
    let router = UserListRouter()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(transition: .crossDissolve(0.25))
    
        Task {
            await interactor.loadData()
            DispatchQueue.main.async {
                self.tableView.hideSkeleton(transition: .crossDissolve(0.25))
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Table view data source
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

// MARK: - Table view delegate
extension UserListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = interactor.user(at: indexPath.row) else { return }
        router.showUserDetail(with: user, fromViewController: self)
    }
}

// MARK: - Skeleton data source
extension UserListTableViewController {
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        if let cell = cell as? UserListTableViewCell {
            cell.setupSkeletonView()
        }
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return Self.cellIdentifier
    }

    func collectionSkeletonView(_ skeletonView: UITableView, prepareCellForSkeleton cell: UITableViewCell, at indexPath: IndexPath) {
    }
}
