//
//  UserListInteractor.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/17.
//

import UIKit

final class UserListInteractor {
    private let network = Network()
    private var userList = [User]()
    
    var numberOfUser: Int {
        return userList.count
    }
    
    func loadData() async {
        guard let userList = try? await network.userList() else { return }
        self.userList = userList
    }
    
    func user(at index: Int) -> User? {
        guard index < userList.count else { return nil }
        return userList[index]
    }
}
