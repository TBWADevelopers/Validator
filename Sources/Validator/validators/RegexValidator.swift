//
//  RegexValidator.swift
//  Validator
//
//  Created by iOS2021 on 25.05.2021.
//

import Foundation

public struct RegexValidator: Validator {
    public var id: String?
    public let pattern: String
    
    public init(id: String? = nil, pattern: String) {
        self.id = id
        self.pattern = pattern
    }
    
    public func validate(input: String) -> ValidatorResult {
        if input.regex(pattern).isEmpty {
            return ValidatorResult(id: id, error: .regex)
        }
        return ValidatorResult(id: id, error: nil)
    }
}

public extension RegexValidator {
    static func email(id: String? = nil) -> Self {
        let pattern = #"^(?:[\w!#$%&'*+=?^`{|}~-]+(?:\.[\w!#$%&'*+=?^`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[\w-]*[\w]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$"#
        return RegexValidator(id: id, pattern: pattern)
    }
}
