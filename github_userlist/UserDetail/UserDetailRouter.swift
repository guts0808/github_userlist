//
//  UserDetailRouter.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/18.
//

import UIKit
import SafariServices

class UserDetailRouter {
    func showWebView(with repository: Repository, fromViewController: UIViewController) {
        guard let urlStr = repository.htmlURL,
              let url = URL(string: urlStr) else { return }
        
        let viewController = SFSafariViewController(url: url)
        fromViewController.present(viewController, animated: true)
    }
}
