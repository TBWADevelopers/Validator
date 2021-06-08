//
//  Extensions+Array.swift
//  Validator
//
//  Created by iOS2021 on 25.05.2021.
//

import Foundation

public protocol SomeValidator {}

public protocol StringValidator: SomeValidator {
    func validate(input: String) -> ValidatorResult
}

extension RegexValidator: StringValidator {}
extension LenghtValidator: StringValidator {}

private protocol DateValidator: SomeValidator {
    func validate(input: Date) -> ValidatorResult
}

extension AgeValidator: DateValidator {}

struct Validators<V> {
    private let array: [SomeValidator]
}

extension Validators: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: SomeValidator...) {
        self.array = Array(elements)
    }
}

extension Validators where V == String {
    func validate(input: String) -> ValidatorResult {
        let strings = array.compactMap { $0 as? StringValidator }
        for validator in strings {
            let result = validator.validate(input: input)
            if result.error != nil {
                return result
            }
        }

        return ValidatorResult(error: nil)
    }
}

extension Validators where V == Date {
    func validate(input: Date) -> ValidatorResult {
        let dates = array.compactMap { $0 as? DateValidator }
        for validator in dates {
            let result = validator.validate(input: input)
            if result.error != nil {
                return result
            }
        }

        return ValidatorResult(error: nil)
    }
}
