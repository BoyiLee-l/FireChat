//
//  FireChatTests.swift
//  FireChatTests
//
//  Created by DuncanLi on 2023/10/2.
//

import XCTest
@testable import FireChat

final class FireChatTests: XCTestCase {
    var sut: AuthService!
    var session: URLSession!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = AuthService()
        session = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        session = nil
        super.tearDown()
    }

    func testLogin() throws {
        let email = "123456@gmail.com"
        let password = "Aa123456"
       
        let expectation = XCTestExpectation(description: "Login expectation")
        
        sut.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else {
                XCTAssertNotNil(result, "Login result should not be nil for successful login")
                XCTAssertEqual(result?.user.email, email, "User email should match the provided email")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testAPI() {
        guard let url = URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json") else { return }
        let promise = expectation(description: "status code: 200")
        var responseError: Error?
        var statusCode: Int?
        
        session.dataTask(with: url) { data, response, error in
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }.resume()
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
