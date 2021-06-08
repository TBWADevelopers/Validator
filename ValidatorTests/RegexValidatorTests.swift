//
//  ValidatorTests.swift
//  ValidatorTests
//
//  Created by iOS2021 on 19.05.2021.
//

import XCTest
@testable import Validator

class RegexValidatorTests: XCTestCase {

    func testValidRegexValidator() throws {
        let input = "abcd"
        
        let regex = #"[a-z]"#
        let validator = RegexValidator(pattern: regex)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testInvalidRegexValidator() throws {
        let input = "123"
        
        let regex = #"[a-z]"#
        let validator = RegexValidator(pattern: regex)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .regex)
    }
    
    func testValidWithDigitsRegexValidator() throws {
        let input = "avc123"
        
        let regex = #"[a-z]"#
        let validator = RegexValidator(pattern: regex)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testEmptyRegexValidator() throws {
        let input = "123"
        
        let regex = #""#
        let validator = RegexValidator(pattern: regex)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .regex)
    }
    
    func testDoubleRegexValidator() throws {
        let input = "abcd"

        let validator1 = RegexValidator(id: "1", pattern: #"[a-z]"#)
        let validator2 = RegexValidator(id: "2", pattern: #"[0-9]"#)
        
        let validators: Validators<String> = [validator1, validator2]
        let result = validators.validate(input: input)
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .regex)
        XCTAssertEqual(result.id, "2")
    }
}
