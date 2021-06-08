//
//  CombinedValidatorTests.swift
//  ValidatorTests
//
//  Created by iOS2021 on 19.05.2021.
//

import XCTest
@testable import Validator

class CombinedValidatorTests: XCTestCase {

    func testInvalidRegex() throws {
        let input = "some text with numbers 11"
        let result = input
                .validator()
                .regex(pattern: #"^[A-Za-z ]+$"#)
                .lenght(min: 1, max: 10)
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .regex)
    }
    
    func testInvalidLenght() throws {
        let input = "some long long long text"
        
        let result = input
                .validator()
                .regex(pattern: #"^[A-Za-z ]+$"#)
                .lenght(min: 1, max: 10)
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .maxLenght)
    }
 
    func testValid() throws {
        let input = "some long long long text"
        
        let result = input
                .validator()
                .regex(pattern: #"^[A-Za-z ]+$"#)
                .lenght(min: 1, max: 100)
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
}
