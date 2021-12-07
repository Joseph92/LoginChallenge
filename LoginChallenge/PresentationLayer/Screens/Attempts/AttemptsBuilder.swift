//
//  AttemptsBuilder.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation
import AGSecureStore

//Builder Pattern
protocol AttemptsBuilderProtocol {
    func build(coordinator: AttemptsCoordinator) -> AttemptsViewController
}

final class AttemptsBuilder: AttemptsBuilderProtocol {
    func build(coordinator: AttemptsCoordinator) -> AttemptsViewController {
        // Inject dependencies
        let localStorage = UserDefaultsHandler()
        let getAttemptsUseCase = GetAttemptsUseCase(localStorage: localStorage)
        let presenter = AttemptsPresenter(getAttemptsUseCase: getAttemptsUseCase)
        let vc = AttemptsViewController()
        presenter.view = vc
        presenter.coordinator = coordinator
        vc.presenter = presenter
        return vc
    }
}
