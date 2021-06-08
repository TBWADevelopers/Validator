//
//  AgeValidatorTests.swift
//  ValidatorTests
//
//  Created by iOS2021 on 25.05.2021.
//

import XCTest
@testable import Validator

class AgeValidatorTests: XCTestCase {

    func testValidAge() throws {
        let input = Date(timeIntervalSince1970: 0)
        let validator = AgeValidator(age: 18)
        let result = validator.validate(input: input)
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testInvalidAge() throws {
        let input = Date()
        let validator = AgeValidator(age: 18)
        let result = validator.validate(input: input)
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .age)
    }
    
    func testRangeValidAge() throws {
        let input = Date(timeIntervalSince1970: 0)
        let validator = AgeValidator(range: 18...60)
        let result = validator.validate(input: input)

        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testRangeInvalidAge() throws {
        let input = Date()
        let validator = AgeValidator(range: 18...60)
        let result = validator.validate(input: input)

        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .age)
    }
    
    func testClosedRangeValid() throws {
        let input = Date()
        let validator = AgeValidator(range: ...18)
        let result = validator.validate(input: input)
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
}
