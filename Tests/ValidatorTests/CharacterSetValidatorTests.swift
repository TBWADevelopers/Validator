//
//  CharacterSetValidatorTests.swift
//  ValidatorTests
//
//  Created by iOS2021 on 25.05.2021.
//

import XCTest
@testable import Validator

class CharacterSetValidatorTests: XCTestCase {

    func testValidTest() throws {
        let input = "10 abs"

        let set = CharacterSet
            .decimalDigits
            .union(.whitespaces)
            .union(.letters)
        
        let validator = CharacterSetValidator(set: set)
        let result = validator.validate(input: input)
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testInvalidTest() throws {
        let input = "some 11"

        let set = CharacterSet
            .decimalDigits
            .union(.whitespaces)
        
        let validator = CharacterSetValidator(set: set)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .characterSet)
    }
    
    func testInvalidInvertedTest() throws {
        let input = "11"

        let set = CharacterSet
            .decimalDigits
            .inverted
        
        let validator = CharacterSetValidator(set: set)
        let result = validator.validate(input: input)
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .characterSet)
    }
}
