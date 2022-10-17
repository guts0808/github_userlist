//
//  Network.swift
//  github_userlist
//
//  Created by 金善徳 on 2022/10/14.
//

import Foundation

class Network {    
    func userList() async throws -> [User]? {
        guard let url = URL(string: "https://api.github.com/users") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["accept": "application/vnd.github+json",
                                       "Authorization": "Bearer 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"]
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let result = try? await session.data(for: request)
        guard let data = result?.0,
              let decodedResponse = try? JSONDecoder().decode([User].self, from: data) else { return nil }
        return decodedResponse
    }
    
    func user(userName: String) async throws -> UserDetail? {
        guard let url = URL(string: "https://api.github.com/users/\(userName)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["accept": "application/vnd.github+json",
                                       "Authorization": "Bearer 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"]
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let result = try? await session.data(for: request)
        guard let data = result?.0,
              let decodedResponse = try? JSONDecoder().decode(UserDetail.self, from: data) else { return nil }
        return decodedResponse
    }
}


