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
}

public struct ValidatorResult {
    var id: String?
    var error: ValidationError?
    var isValid: Bool { error == nil }
}

public protocol Validator {
    associatedtype T
    var id: String? { get }
    func validate(input: T) -> ValidatorResult
}

