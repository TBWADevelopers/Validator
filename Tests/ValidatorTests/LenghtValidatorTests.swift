//
//  LenghtValidatorTests.swift
//  ValidatorTests
//
//  Created by iOS2021 on 19.05.2021.
//

import XCTest
@testable import Validator

class LenghtValidatorTests: XCTestCase {

    func testValid() throws {
        let input = "TestText"

        let validator = LenghtValidator(min: 1, max: 10)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testInvalidEmpty() throws {
        let input = ""

        let validator = LenghtValidator(min: 1, max: 10)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .minLenght)
    }
    
    func testInvalidLong() throws {
        let input = "TextMoreThanMax!"

        let validator = LenghtValidator(min: 1, max: 10)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .maxLenght)
    }
    
    func testValidMin() throws {
        let input = "1"

        let validator = LenghtValidator(min: 1, max: 10)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testValidMax() throws {
        let input = "12345"

        let validator = LenghtValidator(min: 1, max: 5)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testValidNilMin() throws {
        let input = "1"

        let validator = LenghtValidator(max: 10)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testValidNilMax() throws {
        let input = "1"

        let validator = LenghtValidator(min: 1)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testInvalidNilMin() throws {
        let input = "0123456789012345"

        let validator = LenghtValidator(max: 10)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .maxLenght)
    }
    
    func testInvalidNilMax() throws {
        let input = "1"

        let validator = LenghtValidator(min: 2)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .minLenght)
    }
    
    func testValidExactLenght() throws {
        let input = "333"

        let validator = LenghtValidator(exact: 3)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testInvalidMaxExactLenght() throws {
        let input = "4444"

        let validator = LenghtValidator(exact: 3)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .maxLenght)
    }
    
    func testInvalidMinExactLenght() throws {
        let input = "22"

        let validator = LenghtValidator(exact: 3)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .minLenght)
    }
}
