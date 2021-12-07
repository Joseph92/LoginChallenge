//
//  LoginPresenterTests.swift
//  LoginChallengeTests
//
//  Created by Josseph Colonia on 7/12/21.
//

import XCTest
@testable import LoginChallenge

class LoginPresenterTests: XCTestCase {
    var presenter: LoginPresenter! //SUT
    var loginUseCaseMock: LoginUseCaseMock! // MOCK
    var registerUseCaseMock: RegisterUseCaseMock! // MOCK
    var viewMock: LoginViewMock! // MOCK
    
    override func setUp() {
        viewMock = LoginViewMock()
        loginUseCaseMock = LoginUseCaseMock()
        registerUseCaseMock = RegisterUseCaseMock()
        presenter = LoginPresenter(getNewsListUseCase: loginUseCaseMock, registerUseCase: registerUseCaseMock)
        presenter.view = viewMock
        viewMock.loginStateCalled = false
        viewMock.messageStateCalled = false
        viewMock.errorStateCalled = false
    }
    
    func testSignInSuccess() {
        // Given
        let username = "test@appgate.com"
        let password = "Appg4te*"
        loginUseCaseMock.result = .success(.init(username: username, password: password))
        // When
        presenter.signinUserAccount(username: username, password: password)
        // Then
        XCTAssertTrue(viewMock.loginStateCalled)
    }
    
    func testSignInFailure() {
        // Given
        let username = "test@appgate.com"
        let password = "123456"
        loginUseCaseMock.result = .failure(NSError(domain: "API ERROR", code: 500, userInfo: nil))
        // When
        presenter.signinUserAccount(username: username, password: password)
        // Then
        XCTAssertTrue(viewMock.messageStateCalled)
    }
    
    func testRegisterUserAccountSuccess() {
        // Given
        let username = "test@appgate.com"
        let password = "Appg4te*"
        registerUseCaseMock.result = .success(.init(username: username, password: password))
        // When
        presenter.registerUserAccount(username: username, password: password)
        // Then
        XCTAssertTrue(viewMock.messageStateCalled)
    }
    
    func testRegisterUserAccountFailure() {
        // Given
        let username = "test@appgate.com"
        let password = "Appg4te*"
        registerUseCaseMock.result = .failure(NSError(domain: "API ERROR", code: 500, userInfo: nil))
        // When
        presenter.registerUserAccount(username: username, password: password)
        // Then
        XCTAssertTrue(viewMock.messageStateCalled)
    }
    
    func testEmptyFields() {
        // Given
        let username = "test@appgate.com"
        let password = ""
        loginUseCaseMock.result = .success(.init(username: username, password: password))
        // When
        presenter.signinUserAccount(username: username, password: password)
        // Then
        XCTAssertTrue(viewMock.errorStateCalled)
    }
    
    func testInvalidEmail() {
        // Given
        let username = "test@appgate"
        let password = "Appg4te*"
        registerUseCaseMock.result = .success(.init(username: username, password: password))
        // When
        presenter.registerUserAccount(username: username, password: password)
        // Then
        XCTAssertTrue(viewMock.errorStateCalled)
    }
    
    func testInvalidPassword() {
        // Given
        let username = "test@appgate.com"
        let password = "appgate*"
        registerUseCaseMock.result = .success(.init(username: username, password: password))
        // When
        presenter.registerUserAccount(username: username, password: password)
        // Then
        XCTAssertTrue(viewMock.errorStateCalled)
    }
}

private extension LoginPresenterTests {
    func getModel() -> UserModel {
        return .init(username: "test@appgate.com", password: "Appg4te*")
    }
}
