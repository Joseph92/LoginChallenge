//
//  LoginUseCase.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 5/12/21.
//

import Foundation
import AGSecureStore
import CoreLocation

protocol LoginUseCaseProtocol {
    var provider: LoginProviderProtocol { get }
    
    func run(model: UserModel, completion: @escaping (Result<UserModel, Error>) -> ())
}

final class LoginUseCase: LoginUseCaseProtocol {
    var provider: LoginProviderProtocol
    private var locManager = CLLocationManager()
    private var secureStorage: LocalProviderHandler
    private var localStorage: LocalProviderHandler
    
    init(provider: LoginProviderProtocol,
         secureStorage: LocalProviderHandler,
         localStorage: LocalProviderHandler) {
        self.provider = provider
        self.secureStorage = secureStorage
        self.localStorage = localStorage
        locManager.requestWhenInUseAuthorization()
    }
    
    func run(model: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {
        if locManager.authorizationStatus == .authorizedWhenInUse || locManager.authorizationStatus == .authorizedAlways {
            let longitud = String(locManager.location?.coordinate.longitude ?? 0)
            let latitude = String(locManager.location?.coordinate.latitude ?? 0)
            
            provider.getDateLogin(lat: latitude, lon: longitud) { [weak self] result in
                switch result {
                case let .success(entity):
                    let isLoginValid = self?.validateUser(model: model) ?? false
                    self?.saveAttempt(date: entity.currentDate, status: isLoginValid)
                    isLoginValid ? completion(.success(model)) : completion(.failure(NSError(domain: "login Failure", code: 0, userInfo: nil)))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(NSError(domain: "Location permission denied", code: 0, userInfo: nil)))
        }
    }
    
    private func validateUser(model: UserModel) -> Bool {
        guard let user: String = secureStorage["username"],
              let pass: String = secureStorage["password"] else {
                  return false
              }
        return user.elementsEqual(model.username) && pass.elementsEqual(model.password)
    }
    
    private func saveAttempt(date: String, status: Bool) {
        let attemptsData: Data? = localStorage["attempts"]
        var attempts: [AttemptModel] = attemptsData != nil ?
            (try? PropertyListDecoder().decode([AttemptModel].self, from: attemptsData!)) ?? [] : []
        let attempt = AttemptModel(date: date, status: status)
        attempts.append(attempt)
        localStorage["attempts"] = try? PropertyListEncoder().encode(attempts)
    }
}
