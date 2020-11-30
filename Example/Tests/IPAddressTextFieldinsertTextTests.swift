//
//  IPTextFieldTests.swift
//  IPTextFieldTests
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import XCTest
@testable import IPTextField

class IPAddressTextFieldinsertTextTests: XCTestCase {
    
    // MARK: - Setup
    
    var ipAddressTextField: IPTextField!

    override func setUp() {
        super.setUp()
        ipAddressTextField = IPTextField()
    }
    
    override func tearDown() {
        ipAddressTextField = nil
        super.tearDown()
    }
    
    // MARK: - Valid inserts
    func testInsertTextAt0() {
        
        do {
            try ipAddressTextField.insertText(at: 0, text: "222")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(try ipAddressTextField.text(at: 0), "222")
    }
    
    func testInsertTextAt1() {
        do {
            try         ipAddressTextField.insertText(at: 1, text: "222")
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(try ipAddressTextField.text(at: 1), "222")
    }
    func testInsertTextAt2() {
        do {
            try ipAddressTextField.insertText(at: 2, text: "222")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(try ipAddressTextField.text(at: 2), "222")
    }
    
    func testInsertTextAt3() {
        do {
            try ipAddressTextField.insertText(at: 3, text: "222")
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(try ipAddressTextField.text(at: 3), "222")
    }
    
    // MARK: - Invalid positions
    
    func testInsertTextPositionSmallerThan0() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(at: -1, text: "222")) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidPosition.rawValue)
    }
    
    func testInsertTextPositionBiggerThan3() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(at: 4, text: "222")) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidPosition.rawValue)
    }
    
    // MARK: - Invalid characters
    
    func testInsertTextLetters() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(at: 0, text: "aba")) {
            error = $0
        }

        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidCharacter.rawValue)
    }
    
    func testInsertTextSpace() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(at: 0, text: "1 0")) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidCharacter.rawValue)
    }
    
    func testInsertTextNegativeDigits() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(at: 0, text: "-1")) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidCharacter.rawValue)
    }
    
    // MARK: - Invalid length
    
    func testInsertText0Characters() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(at: 0, text: "")) {
            error = $0
        }

        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidNumber.rawValue)
    }
    
    func testInsertText4Characters() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(at: 0, text: "")) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidNumber.rawValue)
    }
    
    func testInsertText1Characters() {
        do {
            try ipAddressTextField.insertText(at: 0, text: "1")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(try ipAddressTextField.text(at: 0), "1")
    }
    func testInsertText2Characters() {
        do {
            try ipAddressTextField.insertText(at: 0, text: "11")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(try ipAddressTextField.text(at: 0), "11")
    }
    func testInsertText3Characters() {
        do {
            try ipAddressTextField.insertText(at: 0, text: "111")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(try ipAddressTextField.text(at: 0), "111")
    }
    
    // MARK: - Numbers
    func testInsertTextBiggerThan255() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(at: 0, text: "256")) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidNumber.rawValue)
    }
    
    func testInsertTextUpperLimit() {
        do {
            try ipAddressTextField.insertText(at: 0, text: "255")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(try ipAddressTextField.text(at: 0), "255")
    }
    
    func testInsertNumberStartingWith0() {
        do {
            try ipAddressTextField.insertText(at: 0, text: "001")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(try ipAddressTextField.text(at: 0), "001")
    }
    
    // MARK: - Insert all
    func testInsertAllText() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(try ipAddressTextField.text(at: 0), "134")
        XCTAssertEqual(try ipAddressTextField.text(at: 1), "12")
        XCTAssertEqual(try ipAddressTextField.text(at: 2), "001")
        XCTAssertEqual(try ipAddressTextField.text(at: 3), "23")
    }
    
    func testInsertAllFailFirst() {
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(part1: "901", part2: "12", part3: "001", part4: "23"))
        
        XCTAssertTrue(self.ipAddressTextField.isEmpty())
    }
    
    func testInsertAllFailLast() {
        
        XCTAssertThrowsError(try ipAddressTextField.insertText(part1: "255", part2: "12", part3: "001", part4: "2300"))
        
        XCTAssertTrue(self.ipAddressTextField.isEmpty())
    }
}
