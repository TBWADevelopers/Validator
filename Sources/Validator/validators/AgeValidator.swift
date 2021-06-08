//
//  AgeValidator.swift
//  Validator
//
//  Created by iOS2021 on 25.05.2021.
//

import Foundation

public struct AgeValidator: Validator {
    public var id: String?
    public let range: Range<Int>
    
    public init(id: String? = nil, range: Range<Int>) {
        self.id = id
        self.range = range
    }
    
    public func validate(input: Date) -> ValidatorResult {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year], from: input, to: Date())
        let years = dateComponents.year ?? 0
        
        if !range.contains(years) {
            return ValidatorResult(id: id, error: .age)
        }
    
        return ValidatorResult(id: id, error: nil)
    }
}

public extension AgeValidator {
    init(id: String? = nil, age: Int) {
        self.init(id: id, range: age..<Int.max)
    }
    
    init(id: String? = nil, range: ClosedRange<Int>) {
        self.init(id: id, range: Range(range))
    }
    
    init(id: String? = nil, range: PartialRangeThrough<Int>) {
        self.init(id: id, range: 0...range.upperBound)
    }
    
    init(id: String? = nil, range: PartialRangeFrom<Int>) {
        self.init(id: id, range: range.lowerBound..<Int.max)
    }
}
