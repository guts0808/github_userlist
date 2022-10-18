//
//  UserDetailTableViewController.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit
import SkeletonView

class UserDetailTableViewController: UITableViewController, SkeletonTableViewDataSource {
    static let cellIdentifier = "Cell"
    static let headerIdentifier = "Header"
    let interactor: UserDetailInteractor
    let router = UserDetailRouter()
    
    init(userName: String) {
        self.interactor = UserDetailInteractor(userName: userName)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
        tableView.register(UserDetailTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: Self.headerIdentifier)
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton()
        Task {
            await interactor.loadData()
            DispatchQueue.main.async {
                self.tableView.hideSkeleton()
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
        return interactor.numberOfRepository
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        if let cell = cell as? UserDetailTableViewCell,
           let repository = interactor.repository(at: indexPath.row) {
            cell.style(repository: repository)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.headerIdentifier)
        if let headerView = headerView as? UserDetailTableViewHeaderView {
            if let userDetail = interactor.getUserDetail() {
                if headerView.sk.isSkeletonActive {
                    headerView.hideSkeleton()
                }
                headerView.style(userDetail: userDetail)
            } else {
                headerView.setupSkeletonView()
                headerView.showAnimatedGradientSkeleton()
            }
        }
        return headerView
    }
}

// MARK: - Table view delegate
extension UserDetailTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repository = interactor.repository(at: indexPath.row) else { return }
        router.showWebView(with: repository, fromViewController: self)
    }
}

// MARK: - Skeleton data source
extension UserDetailTableViewController {
    
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath)
        if let cell = cell as? UserDetailTableViewCell {
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
