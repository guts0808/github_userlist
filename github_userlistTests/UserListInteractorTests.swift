//
//  UserListInteractorTests.swift
//  github_userlistTests
//
//  Created by 金善徳 on 2022/10/17.
//

import XCTest
import OHHTTPStubs
@testable import github_userlist

final class UserListInteractorTests: XCTestCase {
    let interactor = UserListInteractor()

    func testNumberOfUser() async throws {
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users"
        }, withStubResponse: { request in
            return HTTPStubsResponse(data: MockData.jsonData(at: "MockUserListResponse"), statusCode: 200, headers: nil)
        })
        
        await interactor.loadData()
        XCTAssertTrue(interactor.numberOfUser > 0)
    }
    
    func testUserAt() async throws {
        HTTPStubs.stubRequests(passingTest: { request in
            return request.url?.absoluteString == "https://api.github.com/users"
        }, withStubResponse: { request in
            return HTTPStubsResponse(data: MockData.jsonData(at: "MockUserListResponse"), statusCode: 200, headers: nil)
        })
        
        await interactor.loadData()
        XCTAssertNotNil(interactor.user(at: 0))
    }

}
