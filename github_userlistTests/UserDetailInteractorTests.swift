//
//  UserDetailInteractorTests.swift
//  github_userlistTests
//
//  Created by 金善徳 on 2022/10/18.
//

import XCTest
import OHHTTPStubs
@testable import github_userlist

final class UserDetailInteractorTests: XCTestCase {
    let interactor = UserDetailInteractor(userName: "test")

    func testNumberOfRepository() async throws {
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users"
        }, withStubResponse: { request in
            return HTTPStubsResponse(data: MockData.jsonData(at: "MockRepositoryListResponse"), statusCode: 200, headers: nil)
        })
        
        await interactor.loadData()
        XCTAssertTrue(interactor.numberOfRepository > 0)
    }
    
    func testUserAt() async throws {
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users"
        }, withStubResponse: { request in
            return HTTPStubsResponse(data: MockData.jsonData(at: "MockUserListResponse"), statusCode: 200, headers: nil)
        })
        
        await interactor.loadData()
        XCTAssertNotNil(interactor.repository(at: 0))
    }
    
    func testGetUserDetail() async throws {
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users"
        }, withStubResponse: { request in
            return HTTPStubsResponse(data: MockData.jsonData(at: "MockUserListResponse"), statusCode: 200, headers: nil)
        })
        
        await interactor.loadData()
        XCTAssertNotNil(interactor.getUserDetail())
    }

}
