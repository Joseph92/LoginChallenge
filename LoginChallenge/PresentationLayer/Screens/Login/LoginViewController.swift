//
//  LoginViewController.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 5/12/21.
//

import UIKit

protocol LoginViewProtocol: NSObject {
    func changeState(_ state: LoginViewStates)
}

final class LoginViewController: UIViewController {
    private enum StateView {
        case login
        case register
    }
    
    var presenter: LoginPresenterProtocol?
    private var state: StateView = .login
    
    // MARK: - Constants
    private let primaryColor = #colorLiteral(red: 0.04919287562, green: 0.04920699447, blue: 0.04918977618, alpha: 1)
    private let accentColor = #colorLiteral(red: 0.8439802527, green: 0.2606859803, blue: 0.001232604496, alpha: 1)
    private let loginText = "SIGN IN"
    private let registerText = "Create Account"
    
    // MARK: - UIComponents
    private lazy var headerImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "appgatelogo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        textField.textColor = primaryColor
        textField.keyboardType = .emailAddress
        textField.font = .systemFont(ofSize: 20, weight: .regular)
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 4.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = primaryColor.cgColor
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.textColor = primaryColor
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 20, weight: .regular)
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 4.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = primaryColor.cgColor
        textField.delegate = self
        return textField
    }()
    
    private lazy var changeStateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(accentColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    private lazy var primaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(accentColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = primaryColor
        button.layer.cornerRadius = 4.0
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension LoginViewController {
    func setupUI() {
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        
        setupHeaderImage()
        setupVerticalStackView()
        setupUsernameTextField()
        setupPasswordTextField()
        setupPrimaryButton()
        setupChangeStateButton()
    }
    
    func setupHeaderImage() {
        view.addSubview(headerImage)
        headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func setupVerticalStackView() {
        view.addSubview(verticalStackView)
        verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupUsernameTextField() {
        verticalStackView.addArrangedSubview(usernameTextField)
    }
    
    func setupPasswordTextField() {
        verticalStackView.addArrangedSubview(passwordTextField)
    }
    
    func setupPrimaryButton() {
        verticalStackView.addArrangedSubview(primaryButton)
        primaryButton.addTarget(self, action: #selector(primaryButtonEvent), for: .touchUpInside)
    }
    
    func setupChangeStateButton() {
        view.addSubview(changeStateButton)
        changeStateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        changeStateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeStateButton.addTarget(self, action: #selector(changeStateButtonEvent), for: .touchUpInside)
    }
    
    @objc
    func primaryButtonEvent(sender: UIButton) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else {
                  return
              }
        if state == .login {
            presenter?.signinUserAccount(username: username, password: password)
        } else {
            presenter?.registerUserAccount(username: username, password: password)
        }
    }
    
    @objc
    func changeStateButtonEvent(sender: UIButton) {
        if state == .login {
            state = .register
            primaryButton.setTitle(registerText, for: .normal)
            changeStateButton.setTitle(loginText, for: .normal)
        } else {
            state = .login
            primaryButton.setTitle(loginText, for: .normal)
            changeStateButton.setTitle(registerText, for: .normal)
        }
    }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: LoginViewProtocol {
    func changeState(_ state: LoginViewStates) {
        switch state {
        case .clear:
            usernameTextField.text = ""
            passwordTextField.text = ""
        case .load:
            // call load animation logic
            break
        case .login:
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.coordinator?.toAttempts()
            }
        case .register:
            self.state = .register
        case let .message(text):
            DispatchQueue.main.async { [weak self] in
                self?.showMessage(title: "Message", message: text)
            }
        case let .error(text):
            DispatchQueue.main.async { [weak self] in
                self?.showMessage(title: "Error", message: text)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
