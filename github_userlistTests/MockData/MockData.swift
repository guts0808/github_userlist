//
//  MockData.swift
//  github_userlistTests
//
//  Created by 金善徳 on 2022/10/15.
//

import Foundation

final class MockData {
    static func jsonData(at filePath: String) -> Data {
        guard let mock = Bundle(for: Self.self).path(forResource: filePath, ofType: "json"),
              let data = try? Data(contentsOf: URL(filePath: mock)) else {
            return Data()
        }
        
        return data
    }
}
