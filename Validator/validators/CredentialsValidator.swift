//
//  CredentialsValidator.swift
//  Validator
//
//  Created by iOS2021 on 02.06.2021.
//

import Foundation

public struct Credentials {
    let login: String
    let password: String
    var passwordAgain: String?
}

public enum CredentialsError: Equatable {
    case login
    case password
    case misMatchPassword
}

public struct CredentialsValidator: Validator {
    
    public var id: String?
    public let login: StringValidator
    public let password: StringValidator
    
    public func validate(input: Credentials) -> ValidatorResult {
        
        let loginResult = login.validate(input: input.login)
        if !loginResult.isValid {
            return ValidatorResult(id: id, error: .credentials(.login))
        }
        
        let passwordResult = password.validate(input: input.password)
        if !passwordResult.isValid {
            return ValidatorResult(id: id, error: .credentials(.password))
        }
        
        if let passwordAgain = input.passwordAgain, input.password != passwordAgain {
            return ValidatorResult(id: id, error: .credentials(.misMatchPassword))
        }
        
        return ValidatorResult(id: id, error: nil)
    }
}
