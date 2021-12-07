//
//  AttemptsPresenterTests.swift
//  LoginChallengeTests
//
//  Created by Josseph Colonia on 7/12/21.
//

import XCTest
@testable import LoginChallenge

class AttemptsPresenterTests: XCTestCase {
    var presenter: AttemptsPresenter! //SUT
    var getAttemptsUseCaseMock: GetAttemptsUseCaseMock! // MOCK
    var viewMock: AttemptsViewMock! // MOCK
    
    override func setUp() {
        viewMock = AttemptsViewMock()
        getAttemptsUseCaseMock = GetAttemptsUseCaseMock()
        presenter = AttemptsPresenter(getAttemptsUseCase: getAttemptsUseCaseMock)
        presenter.view = viewMock
        viewMock.renderStateCalled = false
    }
    
    func testRenderSuccess() {
        // Given
        let result = [AttemptModel(date: "10/11/21", status: true),
                      AttemptModel(date: "10/11/21", status: false)]
        getAttemptsUseCaseMock.result = .success(result)
        // When
        presenter.viewLoaded()
        // Then
        XCTAssertTrue(viewMock.renderStateCalled)
    }
}
