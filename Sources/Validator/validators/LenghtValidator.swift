//
//  LenghtValidator.swift
//  Validator
//
//  Created by iOS2021 on 25.05.2021.
//

import Foundation

public struct LenghtValidator: Validator {
    public var id: String?
    public var min: Int?
    public var max: Int?
    
    public init(id: String? = nil, min: Int? = nil, max: Int? = nil) {
        self.id = id
        self.min = min
        self.max = max
    }
    
    public func validate(input: String) -> ValidatorResult {
        if let min = min, input.count < min {
            return ValidatorResult(id: id, error: .minLenght)
        }
        
        if let max = max, input.count > max {
            return ValidatorResult(id: id, error: .maxLenght)
        }
        
        return ValidatorResult(id: id, error: nil)
    }
}

public extension LenghtValidator {
    init(id: String? = nil, exact: Int) {
        self.id = id
        self.min = exact
        self.max = exact
    }
}
