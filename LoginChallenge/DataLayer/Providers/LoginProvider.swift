//
//  LoginProvider.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 5/12/21.
//

import Foundation

protocol LoginProviderProtocol {
    typealias getDateLoginResult = Result<LocationEntity, Error>
    
    func getDateLogin(lat: String, lon: String, completion: @escaping (getDateLoginResult) -> ())
}

final class LoginProvider: LoginProviderProtocol {
    enum LoginService: String {
        case dateLogin = "http://api.geonames.org/timezoneJSON?formatted=true&lat=%@&lng=%@&username=qa_mobile_easy&style=full"
    }
    
    private lazy var urlSession: URLSession = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        return urlSession
    }()
    
    func getDateLogin(lat: String, lon: String, completion: @escaping (getDateLoginResult) -> ()) {
        let url = URL(string: String(format: LoginService.dateLogin.rawValue, lat, lon))
        urlSession.dataTask(with: url!) { data, response, error in
            if error != nil {
                completion(.failure(NSError(domain: "fetch failure", code: 0, userInfo: nil)))
            } else {
                do {
                    let entity = try JSONDecoder().decode(LocationEntity.self, from: data!)
                    completion(.success(entity))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
