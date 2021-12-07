//
//  String+Extensions.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation

extension String {
    func isValidPassword() -> Bool {
        return validateStringWithRegex("^((?=.*\\d)(?=.*[A-Z])(?=.*\\W).{8,})$")
    }
    
    func isValidEmail() -> Bool {
        return validateStringWithRegex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
    
    private func validateStringWithRegex(_ regex: String) -> Bool {
        let text = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let textCheck = NSPredicate(format: "SELF MATCHES %@", regex)
        return textCheck.evaluate(with: text)
    }
}
