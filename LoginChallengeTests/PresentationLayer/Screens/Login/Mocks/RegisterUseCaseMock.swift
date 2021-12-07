//
//  RegisterUseCaseMock.swift
//  LoginChallengeTests
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation
@testable import LoginChallenge

class RegisterUseCaseMock: RegisterUseCaseProtocol {
    var result: Result<UserModel, Error>?
    
    func run(model: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {
        if let result = result {
            completion(result)
        } else {
            completion(.failure(NSError()))
        }
    }
}
