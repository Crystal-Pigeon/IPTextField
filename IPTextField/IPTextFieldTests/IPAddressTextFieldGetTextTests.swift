//
//  IPAddressTextFieldGetTextTests.swift
//  IPTextFieldTests
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import XCTest
@testable import IPTextField

class IPAddressTextFieldGetTextTests: XCTestCase {
    
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
    
    // MARK: - Invalid positions
    func testGetTextPositionSmallerThan0() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.text(at: -1)) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidPosition.rawValue)
    }
    
    func testGetTextPositionBiggerThan3() {
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.text(at: 4)) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidPosition.rawValue)
    }
    
    // MARK: - Valid positions
    func testGetTextPosition0() {
        XCTAssertEqual(try ipAddressTextField.text(at: 0), "")
    }
    
    func testGetTextPosition1() {
        XCTAssertEqual(try ipAddressTextField.text(at: 1), "")
    }
    
    func testGetTextPosition3() {
        XCTAssertEqual(try ipAddressTextField.text(at: 2), "")
    }
    
    func testGetTextPosition4() {
        XCTAssertEqual(try ipAddressTextField.text(at: 3), "")
    }
    
    // MARK: - All text
    func testGetAllText() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(ipAddressTextField.text(), "134.12.001.23")
    }
    
    func testGetAllTextOnly1Part() {
        do {
            try self.ipAddressTextField.insertText(at: 0, text: "11")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(self.ipAddressTextField.text(), "11...")
    }
    func testGetAllTextOnly4Part() {
        do {
            try self.ipAddressTextField.insertText(at: 3, text: "11")
        } catch {
            XCTFail()
        }
        XCTAssertEqual(self.ipAddressTextField.text(), "...11")
    }
    
    func testGetAllTextAllEmpty() {
        XCTAssertEqual(self.ipAddressTextField.text(), "...")
    }
}
