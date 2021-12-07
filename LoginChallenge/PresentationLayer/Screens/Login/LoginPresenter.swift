//
//  LoginPresenter.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 5/12/21.
//

import Foundation

enum LoginViewStates {
    case clear
    case load
    case login
    case register
    case message(String)
    case error(String)
}

protocol LoginPresenterProtocol: NSObject {
    var view: LoginViewProtocol? { get set }
    var coordinator: LoginCoordinator? { get set }
    
    func registerUserAccount(username: String, password: String)
    func signinUserAccount(username: String, password: String)
}

final class LoginPresenter: NSObject, LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    weak var coordinator: LoginCoordinator?
    
    private var state: LoginViewStates = .clear {
        didSet {
            view?.changeState(state)
        }
    }
    
    private let loginUseCase: LoginUseCaseProtocol
    private let registerUseCase: RegisterUseCaseProtocol
    
    init(getNewsListUseCase: LoginUseCaseProtocol, registerUseCase: RegisterUseCaseProtocol) {
        self.loginUseCase = getNewsListUseCase
        self.registerUseCase = registerUseCase
    }
    
    func registerUserAccount(username: String, password: String) {
        if !validateField(username: username, password: password) {
            state = .error("Field empty")
            return
        }
        if !username.isValidEmail() {
            state = .error("Invalid email")
            return
        } else {
            if !password.isValidPassword() {
                state = .error("Invalid password")
                return
            }
        }
        registerUseCase.run(model: .init(username: username, password: password)) { [weak self] result in
            switch result {
            case .success:
                self?.state = .message("Create Account: Success")
            case .failure:
                self?.state = .message("Create Account: Failure")
            }
        }
    }
    
    func signinUserAccount(username: String, password: String) {
        if !validateField(username: username, password: password) {
            state = .error("Field empty")
            return
        }
        loginUseCase.run(model: .init(username: username, password: password)) { [weak self] result in
            switch result {
            case .success:
                self?.state = .login
            case .failure:
                self?.state = .message("Login Failure")
            }
        }
    }
}

extension LoginPresenter {
    func validateField(username: String, password: String) -> Bool {
        if username.isEmpty {
            return false
        } else if password.isEmpty {
            return false
        }
        return true
    }
}
