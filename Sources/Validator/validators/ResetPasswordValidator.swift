//
//  ResetPasswordValidator.swift
//  Validator
//
//  Created by iOS2021 on 08.06.2021.
//

import Foundation

public enum ResetPasswordError: Equatable {
    case old
    case new
    case mismatch
    case notUnique
}

public struct ResetPassword {
    let old: String
    let new: String
    let `repeat`: String?
    
    public init(old: String, new: String, repeat: String?) {
        self.old = old
        self.new = new
        self.repeat = `repeat`
    }
}

public struct ResetPasswordValidator: Validator {
    public var id: String?
    public var unique: Bool = true
    public let password: StringValidator
    
    public init(id: String? = nil, unique: Bool = true, password: StringValidator) {
        self.id = id
        self.unique = unique
        self.password = password
    }
    
    public func validate(input: ResetPassword) -> ValidatorResult {
                
        let oldResult = password.validate(input: input.old)
        if !oldResult.isValid {
            return ValidatorResult(id: id, error: .resetPassword(.old))
        }
        
        let newResult = password.validate(input: input.new)
        if !newResult.isValid {
            return ValidatorResult(id: id, error: .resetPassword(.new))
        }
        
        if let r = input.repeat, r != input.new {
            return ValidatorResult(id: id, error: .resetPassword(.mismatch))
        }
        
        if unique, input.old == input.new {
            return ValidatorResult(id: id, error: .resetPassword(.notUnique))
        }
        
        return ValidatorResult(id: id, error: nil)
    }
}

public extension ResetPasswordValidator {
    init(id: String? = nil, unique: Bool = true, pattern: String) {
        self.password = RegexValidator(id: id, pattern: pattern)
        self.unique = unique
    }
}
