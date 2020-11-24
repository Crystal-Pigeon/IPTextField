//
//  IPAddressTextFieldCheckTextTests.swift
//  IPTextFieldTests
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import XCTest
@testable import IPTextField

class IPAddressTextFieldCheckTextTests: XCTestCase {
    
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
    
    // MARK: - Is complete
    func testIsComplete() {
        do {
        try self.ipAddressTextField.insertText(part1: "0", part2: "0", part3: "0", part4: "0")
        } catch {
            XCTFail()
        }
        XCTAssertTrue(self.ipAddressTextField.isCompleted())
    }
    
    func testIsNotCompleteOnlyFirst() {
        do {
            try self.ipAddressTextField.insertText(at: 0, text: "00")
        } catch {
            XCTFail()
        }
        XCTAssertFalse(self.ipAddressTextField.isCompleted())
    }
    
    func testIsNotCompleteOnlyLast() {
        do {
            try self.ipAddressTextField.insertText(at: 3, text: "00")
        } catch {
            XCTFail()
        }
        XCTAssertFalse(self.ipAddressTextField.isCompleted())
    }
    
    // MARK: - Is Empty
    func testIsEmpty() {
        XCTAssertTrue(self.ipAddressTextField.isEmpty())
    }
    
    func testIsNotEmptyFirst() {
        do {
            try self.ipAddressTextField.insertText(at: 0, text: "00")
        } catch {
            XCTFail()
        }
        XCTAssertFalse(self.ipAddressTextField.isEmpty())
    }
    
    func testIsNotEmptyLast() {
        do {
            try self.ipAddressTextField.insertText(at: 3, text: "00")
        } catch {
            XCTFail()
        }
        XCTAssertFalse(self.ipAddressTextField.isEmpty())
    }
}

