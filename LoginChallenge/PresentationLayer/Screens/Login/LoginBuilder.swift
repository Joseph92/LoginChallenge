//
//  LoginBuilder.swift
//  LoginProvider
//
//  Created by Josseph Colonia on 5LoginProvider/12/21.
//

import Foundation
import AGSecureStore

//Builder Pattern
protocol LoginBuilderProtocol {
    func build(coordinator: LoginCoordinator) -> LoginViewController
}

final class LoginBuilder: LoginBuilderProtocol {
    func build(coordinator: LoginCoordinator) -> LoginViewController {
        // Inject dependencies
        let secureStorage = KeychainService()
        let localStorage = UserDefaultsHandler()
        let vc = LoginViewController()
        let provider = LoginProvider()
        let loginUseCase = LoginUseCase(provider: provider, secureStorage: secureStorage, localStorage: localStorage)
        let registerUserCase = RegisterUseCase(secureStorage: secureStorage, localStorage: localStorage)
        let presenter = LoginPresenter(getNewsListUseCase: loginUseCase, registerUseCase: registerUserCase)
        presenter.view = vc
        presenter.coordinator = coordinator
        vc.presenter = presenter
        return vc
    }
}
