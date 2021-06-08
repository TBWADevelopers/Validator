//
//  Validator.swift
//  Validator
//
//  Created by iOS2021 on 19.05.2021.
//

import Foundation

public enum ValidationError: Equatable {
    case regex
    case minLenght
    case maxLenght
    case characterSet
    case age
    case credentials(CredentialsError)
    case resetPassword(ResetPasswordError)
}

public struct ValidatorResult {
    public var id: String?
    public var error: ValidationError?
    public var isValid: Bool { error == nil }
    
    public init(id: String? = nil, error: ValidationError? = nil) {
        self.id = id
        self.error = error
    }
}

public protocol Validator {
    associatedtype T
    var id: String? { get }
    func validate(input: T) -> ValidatorResult
}

