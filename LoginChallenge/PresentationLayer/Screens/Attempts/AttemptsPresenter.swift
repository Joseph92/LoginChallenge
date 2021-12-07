//
//  AttemptsPresenter.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation

enum AttemptsViewStates {
    case clear
    case render([AttemptModel])
    case error
}

protocol AttemptsPresenterProtocol: NSObject {
    var view: AttemptsViewProtocol? { get set }
    var coordinator: AttemptsCoordinator? { get set }
    
    func viewLoaded()
}

class AttemptsPresenter: NSObject, AttemptsPresenterProtocol {
    weak var view: AttemptsViewProtocol?
    weak var coordinator: AttemptsCoordinator?
    
    private var state: AttemptsViewStates = .clear {
        didSet {
            view?.changeState(state)
        }
    }
    
    private let getAttemptsUseCase: GetAttemptsUseCaseProtocol
    
    init(getAttemptsUseCase: GetAttemptsUseCaseProtocol) {
        self.getAttemptsUseCase = getAttemptsUseCase
    }
    
    func viewLoaded() {
        fetchAttemptsList()
    }
}

private extension AttemptsPresenter {
    func fetchAttemptsList() {
        getAttemptsUseCase.run { [weak self] result in
            switch result {
            case let .success(model):
                self?.state = .render(model)
            case .failure:
                self?.state = .error
            }
        }
    }
}
