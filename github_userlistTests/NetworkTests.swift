//
//  NetworkTests.swift
//  github_userlistTests
//
//  Created by 金善徳 on 2022/10/15.
//

import XCTest
import OHHTTPStubs
@testable import github_userlist

final class NetworkTests: XCTestCase {
    let network = Network()
    
    func testuserListWhenSuccess() async throws {
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users"
        }, withStubResponse: { request in
            return HTTPStubsResponse(data: MockData.jsonData(at: "MockUserListResponse"), statusCode: 200, headers: nil)
        })
        
        let result = try await network.userList()
        XCTAssertNotNil(result)
        XCTAssertFalse(result?.isEmpty == true)
    }
    
    func testuserListWhenSuccessButEmpty() async throws {
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users"
        }, withStubResponse: { request in
            return HTTPStubsResponse(jsonObject: [], statusCode: 200, headers: nil)
        })
        
        let result = try await network.userList()
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.isEmpty == true)
    }
    
    func testuserListWhenFail() async throws {
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users"
        }, withStubResponse: { request in
            return HTTPStubsResponse(data: Data(), statusCode: 404, headers: nil)
        })
        
        let result = try await network.userList()
        XCTAssertNil(result)
    }

    func testuserWhenSuccess() async throws {
        let userName = "test"
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users/\(userName)"
        }, withStubResponse: { request in
            return HTTPStubsResponse(data: MockData.jsonData(at: "MockUserDetailResponse"), statusCode: 200, headers: nil)
        })
        
        let result = try await network.user(userName: userName)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "monalisa octocat")
    }
}

 
