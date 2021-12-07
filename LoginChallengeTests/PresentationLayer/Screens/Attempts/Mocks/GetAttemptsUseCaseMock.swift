//
//  GetAttemptsUseCaseMock.swift
//  LoginChallengeTests
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation
@testable import LoginChallenge

class GetAttemptsUseCaseMock: GetAttemptsUseCaseProtocol {
    var result: Result<[AttemptModel], Error>?
    
    func run(completion: @escaping (Result<[AttemptModel], Error>) -> ()) {
        if let result = result {
            completion(result)
        } else {
            completion(.failure(NSError()))
        }
    }
}
