//
//  UserDetailInteractor.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/18.
//

import Foundation

final class UserDetailInteractor {
    private var userDetail: UserDetail?
    private var repositories = [Repository]()
    private let userName: String
    private let network = Network()
    
    init(userDetail: UserDetail? = nil, repositories: [Repository] = [Repository](), userName: String) {
        self.userDetail = userDetail
        self.repositories = repositories
        self.userName = userName
    }
    
    var numberOfRepository: Int {
        return repositories.count
    }
    
    func loadData() async {
        userDetail = try? await network.user(userName: userName)
        let originalRepo = (try? await network.repositories(userName: userName)) ?? [Repository]()
        repositories = filterOutRepo(original: originalRepo)
    }
    
    private func filterOutRepo(original: [Repository]) -> [Repository] {
        return original.filter({ $0.fork == false })
    }
    
    func repository(at index: Int) -> Repository? {
        guard index < repositories.count else { return nil }
        return repositories[index]
    }
    
    func getUserDetail() -> UserDetail? {
        return userDetail
    }
}
