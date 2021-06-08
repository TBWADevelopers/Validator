//
//  CredentialsValidatorTests.swift
//  ValidatorTests
//
//  Created by iOS2021 on 02.06.2021.
//

import XCTest
@testable import Validator

class CredentialsValidatorTests: XCTestCase {

    func testValid() throws {
        let input = Credentials(login: "lox", password: "021", passwordAgain: "021")
        
        let login = RegexValidator(pattern: "[a-z]")
        let password = RegexValidator(pattern: "[0-9]")
        let validator = CredentialsValidator(login: login, password: password)
        let result = validator.validate(input: input)
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testValidPasswordAgainNil() throws {
        let input = Credentials(login: "lox", password: "021")
        
        let login = RegexValidator(pattern: "[a-z]")
        let password = RegexValidator(pattern: "[0-9]")
        let validator = CredentialsValidator(login: login, password: password)
        let result = validator.validate(input: input)
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testInvalidMisMatch() throws {
        let input = Credentials(login: "lox", password: "092", passwordAgain: "122")
        
        let login = RegexValidator(pattern: "[a-z]")
        let password = RegexValidator(pattern: "[0-9]")
        let validator = CredentialsValidator(login: login, password: password)
        let result = validator.validate(input: input)
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .credentials(.misMatchPassword))
    }
    
    func testInvalidPassword() {
        let login = RegexValidator(pattern: "[a-z]")
        let password = RegexValidator(pattern: "[0-9]")
        let validator = CredentialsValidator(login: login, password: password)
        let input = Credentials(login: "login", password: "NELOX", passwordAgain: "NELOX")
        
        let result = validator.validate(input: input)
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .credentials(.password))
    }
    
    func testInvalidLogin() {
        let login = RegexValidator(pattern: "[a-z]")
        let password = RegexValidator(pattern: "[0-9]")
        let validator = CredentialsValidator(login: login, password: password)
        let input = Credentials(login: "LOGIN", password: "021", passwordAgain: "021")
        
        let result = validator.validate(input: input)
        
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, .credentials(.login))
    }
}
