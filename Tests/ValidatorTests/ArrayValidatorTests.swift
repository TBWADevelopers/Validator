//
//  ArrayValidatorTests.swift
//  ValidatorTests
//
//  Created by iOS2021 on 25.05.2021.
//

import XCTest
@testable import Validator

class ArrayValidatorTests: XCTestCase {

    func testInvalidRegex() throws {
        let input = "some text with numbers 11"
        
        let regexValidator = RegexValidator(pattern: #"^[A-Za-z ]+$"#)
        let lenghtValidator = LenghtValidator(min: 1, max: 10)
        let validators: Validators<String> = [regexValidator, lenghtValidator]
        let result = validators.validate(input: input)
        
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .regex)
    }
    
    func testMixValidatorsValid() {
        let input = "some text with numbers 11"
        
        let regexValidator = RegexValidator(pattern: #"^[A-Za-z ]+$"#)
        let dateValidator = AgeValidator(age: 12)
        
        let validators: Validators<String> = [regexValidator, dateValidator]
        let result = validators.validate(input: input)

        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .regex)
    }
    
    func testInvalidLenght() throws {
        let input = "some text with numbers"
        
        let regexValidator = RegexValidator(pattern: #"^[A-Za-z ]+$"#)
        let lenghtValidator = LenghtValidator(min: 1, max: 5)

        let validators: Validators<String> = [regexValidator, lenghtValidator]
        let result = validators.validate(input: input)
                
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .maxLenght)
    }
    
    func testValid() throws {
        let input = "some text with numbers"
        
        let regexValidator = RegexValidator(pattern: #"^[A-Za-z ]+$"#)
        let lenghtValidator = LenghtValidator(min: 1, max: 25)

        let validators: Validators<String> = [regexValidator, lenghtValidator]
        let result = validators.validate(input: input)
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
}
