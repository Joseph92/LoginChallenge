//
//  GetAttemptsUseCase.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation
import AGSecureStore

protocol GetAttemptsUseCaseProtocol {
    func run(completion: @escaping (Result<[AttemptModel], Error>) -> ())
}

class GetAttemptsUseCase: GetAttemptsUseCaseProtocol {
    private var localStorage: LocalProviderHandler
    
    init(localStorage: LocalProviderHandler) {
        self.localStorage = localStorage
    }
    
    func run(completion: @escaping (Result<[AttemptModel], Error>) -> ()) {
        let attemptsData: Data? = localStorage["attempts"]
        let attempts: [AttemptModel] = attemptsData != nil ?
            (try? PropertyListDecoder().decode([AttemptModel].self, from: attemptsData!)) ?? [] : []
        completion(.success(attempts))
    }
}
