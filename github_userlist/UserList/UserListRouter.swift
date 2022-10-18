//
//  UserListRouter.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/18.
//

import UIKit

class UserListRouter {
    func showUserDetail(with user: User, fromViewController: UIViewController) {
        let userDetail = UserDetailTableViewController(userName: user.login)
        fromViewController.present(userDetail, animated: true)
    }
}
