//
//  IPAddresTextFieldClearTextTests.swift
//  IPTextFieldTests
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import XCTest
@testable import IPTextField

class IPAddressTextFieldClearTextTests: XCTestCase {
    
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
    
    // MARK: - Valid positions
    func testClearPosition0() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        do {
            try ipAddressTextField.clear(at: 0)
        } catch {
            XCTFail()
        }
        XCTAssertEqual(ipAddressTextField.text(), ".12.001.23")
    }
    
    func testClearPosition1() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        do {
            try ipAddressTextField.clear(at: 1)
        } catch {
            XCTFail()
        }
        XCTAssertEqual(ipAddressTextField.text(), "134..001.23")
    }
    
    func testClearPosition2() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        do {
            try ipAddressTextField.clear(at: 2)
        } catch {
            XCTFail()
        }
        XCTAssertEqual(ipAddressTextField.text(), "134.12..23")
    }
    
    func testClearPosition3() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        do {
            try ipAddressTextField.clear(at: 3)
        } catch {
            XCTFail()
        }
        XCTAssertEqual(ipAddressTextField.text(), "134.12.001.")
    }
    
    // MARK: - Invalid Positions
    
    func testClearPositionLessThan0() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.clear(at: -1)) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidPosition.rawValue)
    }
    
    func testClearPositionBiggerThan3() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        
        var error: Error?
        
        XCTAssertThrowsError(try ipAddressTextField.clear(at: 4)) {
            error = $0
        }
        
        XCTAssertEqual(error?.localizedDescription, IPErrorType.invalidPosition.rawValue)
    }
    
    // MARK: - Clear all
    func testClearAll() {
        do {
            try self.ipAddressTextField.insertText(part1: "134", part2: "12", part3: "001", part4: "23")
        } catch {
            XCTFail()
        }
        
        self.ipAddressTextField.clear()
        XCTAssertTrue(self.ipAddressTextField.isEmpty())
    }
}
