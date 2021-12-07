//
//  LoginProviderTests.swift
//  LoginChallengeTests
//
//  Created by Josseph Colonia on 7/12/21.
//

import XCTest
@testable import LoginChallenge

class LoginProviderTests: XCTestCase {
    var provider: LoginProvider! //sut
    
    override func setUp() {
        provider = LoginProvider()
    }
    
    func testGetDateLogin() {
        // When
        let exp = expectation(description: "testGetDateLogin")
        var response: LocationEntity?
        provider.getDateLogin(lat: "-12.095788192221983", lon: "-77.06564104296022"){ result in
            switch result {
            case .success(let resp):
                response = resp
                exp.fulfill()
            case .failure:
                break
            }
        }
        
        // Then
        wait(for: [exp], timeout: 2.0)
        XCTAssertNotNil(response)
    }
}
