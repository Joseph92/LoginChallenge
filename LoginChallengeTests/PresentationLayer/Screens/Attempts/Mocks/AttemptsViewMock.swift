//
//  AttemptsViewMock.swift
//  LoginChallengeTests
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation
@testable import LoginChallenge

class AttemptsViewMock: NSObject, AttemptsViewProtocol {
    var renderStateCalled = false
    
    func changeState(_ state: AttemptsViewStates) {
        switch state {
        case .render:
            renderStateCalled = true
        default:
            break
        }
    }
}
