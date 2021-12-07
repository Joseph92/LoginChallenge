//
//  RegisterUseCase.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 6/12/21.
//

import Foundation
import AGSecureStore

protocol RegisterUseCaseProtocol {
    func run(model: UserModel, completion: @escaping (Result<UserModel, Error>) -> ())
}

final class RegisterUseCase: RegisterUseCaseProtocol {
    private var secureStorage: LocalProviderHandler
    private var localStorage: LocalProviderHandler
    
    init(secureStorage: LocalProviderHandler,
         localStorage: LocalProviderHandler) {
        self.secureStorage = secureStorage
        self.localStorage = localStorage
    }
    
    func run(model: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {
        let usr: String? = secureStorage["username"]
        var result = false
        if usr != nil {
            result = secureStorage.update(data: model.username, key: "username") && secureStorage.update(data: model.password, key: "password")
        } else {
            result = secureStorage.save(data: model.username, key: "username") && secureStorage.save(data: model.password, key: "password")
        }
        if result {
            localStorage.delete(key: "attempts")
            completion(.success(model))
        } else {
            completion(.failure(NSError(domain: "Save credentials fail", code: 0, userInfo: nil)))
        }
    }
}
