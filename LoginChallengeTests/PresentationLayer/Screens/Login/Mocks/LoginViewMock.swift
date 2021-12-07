//
//  LoginViewMock.swift
//  LoginChallengeTests
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation
@testable import LoginChallenge

class LoginViewMock: NSObject, LoginViewProtocol {
    var loginStateCalled = false
    var messageStateCalled = false
    var errorStateCalled = false
    
    func changeState(_ state: LoginViewStates) {
        switch state {
        case .login:
            loginStateCalled = true
        case .message:
            messageStateCalled = true
        case .error:
            errorStateCalled = true
        default:
            break
        }
    }
}
