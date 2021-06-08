//
//  CharacterSetValidator.swift
//  Validator
//
//  Created by iOS2021 on 25.05.2021.
//

import Foundation

struct CharacterSetValidator: Validator {
    public var id: String?
    public let set: CharacterSet
    
    public func validate(input: String) -> ValidatorResult {
        if input.rangeOfCharacter(from: set.inverted) != nil {
            return ValidatorResult(id: id, error: .characterSet)
        }
        return ValidatorResult(id: id, error: nil)
    }
    
}
