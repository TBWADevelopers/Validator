//
//  CombinedValidator.swift
//  Validator
//
//  Created by iOS2021 on 25.05.2021.
//

import Foundation

public struct AnyValidator<T>: Validator {
    public var id: String?
    
    private let _validate: (T) -> ValidatorResult
    
    public init<Base: Validator>(_ base: Base) where Base.T == T {
        _validate = base.validate
    }
    
    public func validate(input: T) -> ValidatorResult {
        _validate(input)
    }
}

public class CombinedValidator<T> {
    
    private var validator: AnyValidator<T>?
    private var next: CombinedValidator?
    private let input: T
    
    public init(input: T, validator: AnyValidator<T>?) {
        self.input = input
        self.validator = validator
    }
    
    public var isValid: Bool {
        error == nil
    }
        
    public var error: ValidationError? {
        
        if let error = next?.error {
            return error
        }
        
        let result = validator?.validate(input: input)
        return result?.error
    }
    
    private func next(_ validator: AnyValidator<T>) -> CombinedValidator {
        let cv = CombinedValidator(input: input, validator: validator)
        cv.next = self
        return cv
    }
}

public extension CombinedValidator where T == String {
    func regex(pattern: String) -> CombinedValidator<T> {
        let validator = RegexValidator(pattern: pattern)
        return next(AnyValidator(validator))
    }
    
    func lenght(min: Int?, max: Int?) -> CombinedValidator {
        let validator = LenghtValidator(min: min, max: max)
        return next(AnyValidator(validator))
    }
    
    func character(set: CharacterSet) -> CombinedValidator {
        let validator = CharacterSetValidator(set: set)
        return next(AnyValidator(validator))
    }
}
