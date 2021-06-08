//
//  Extensions+String.swift
//  Validator
//
//  Created by iOS2021 on 25.05.2021.
//

import Foundation

public extension String {
    
    func validator() -> CombinedValidator<String> {
        CombinedValidator(input: self, validator: nil)
    }
    
    func regex(_ pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let string = self as NSString
            let range = NSRange(location: 0, length: string.length)

            let results = regex.matches(in: self, range: range)
            return results.flatMap { result -> [String] in
                let count = 0..<result.numberOfRanges
                return count.map { index in
                    let range = result.range(at: index)
                    if range.location == NSNotFound { return "" }
                    return string.substring(with: range)
                }
            }
        } catch {
            return []
        }
    }
}
