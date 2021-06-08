//
//  EmailValidatorTests.swift
//  ValidatorTests
//
//  Created by iOS2021 on 07.06.2021.
//

import XCTest
@testable import Validator

class EmailValidatorTests: XCTestCase {

    func testValidInputs() throws {

        let expectValid = true
        emailCheck("something@something.com", expectValid)
        emailCheck("someone@localhost.localdomain", expectValid)
        emailCheck("someone@127.0.0.1", expectValid)
        emailCheck("a@b.b", expectValid)
        emailCheck("{}@domain.com", expectValid)
        emailCheck("m*'!%@something.sa", expectValid)
        emailCheck("tu!!7n7.ad##0!!!@company.ca", expectValid)
        emailCheck("%@com.com", expectValid)
        emailCheck("someone@do-ma-in.com", expectValid)
        emailCheck("someon+e@do-ma-in.com", expectValid)
    }
    
    func testInvalidInputs() throws {
        let expectValid = false
        
        emailCheck("a/b@domain.com", expectValid)
        emailCheck("!#$%&'*+/=?^_`{|}~.-@com.com", expectValid)
        emailCheck(".wooly@example.com", expectValid)
        emailCheck("wo..oly@example.com", expectValid)
        emailCheck("somebody@example", expectValid)
        emailCheck(#"\u000Aa@p.com\u000A"#, expectValid)
        emailCheck(#"\u000Da@p.com\u000D"#, expectValid)
        emailCheck(#"a\u000A@p.com"#, expectValid)
        emailCheck(#"a\u000D@p.com"#, expectValid)
        emailCheck("", expectValid)
        emailCheck(" ", expectValid)
        emailCheck(" a@p.com", expectValid)
        emailCheck("a@p.com ", expectValid)
        emailCheck(" a@p.com ", expectValid)
        emailCheck(#"\u0020a@p.com\u0020"#, expectValid)
        emailCheck(#"\u0009a@p.com\u0009"#, expectValid)
        emailCheck(#"\u000Ca@p.com\u000C"#, expectValid)
    }
    
    
    func emailCheck(_ input: String, _ valid: Bool) {
        let validator = RegexValidator.email()
        let result = validator.validate(input: input)
        
        if valid {
            XCTAssertTrue(result.isValid)
            XCTAssertNil(result.error)
        } else {
            XCTAssertFalse(result.isValid)
            XCTAssertEqual(result.error, .regex)
        }
    }
}
