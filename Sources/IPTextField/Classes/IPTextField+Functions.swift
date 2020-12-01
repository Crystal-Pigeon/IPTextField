//
//  IPTextField+Functions.swift
//  IPTextField
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import Foundation

extension IPTextField {
    
    // MARK: - Boolean functions
    
    /// This method returns true if every part of the ip address text field contains some text
    /// - Returns: A boolean value inidicating whether the given ip address text field is completed
    public func isCompleted() -> Bool {
        for textField in textFields {
            if textField.text!.isEmpty {
                return false
            }
        }
        return true
    }
    
    /// This method returns true if every part of the ip addres is empty
    /// - Returns: A boolean value inidcating whether the given ip address text field is empty
    public func isEmpty() -> Bool {
        for textField in textFields {
            if !textField.text!.isEmpty {
                return false
            }
        }
        return true
    }
    
    // MARK: - Get text functions
    
    /// This method returns the ip address inserted in the text field
    /// - Returns: A string in the ip address format
    public func text() -> String {
        return "\(textFields[0].text!).\(textFields[1].text!).\(textFields[2].text!).\(textFields[3].text!)"
    }
    
    /// This method returns the  text in the ip address in the given position
    /// - Parameter position : The position of the text field
    /// - Returns: A string containing the part of the ip address at the given position
    /// - Warning: The first position is 0
    /// - Throws: IPError
    public func text(at position: Int) throws -> String {
        guard position >= 0 && position <= 3 else { throw IPError(type: IPErrorType.invalidPosition) }
        return self.textFields[position].text!
    }
    
    // MARK: - Insert text functions
    
    /// This method inserts text inside the text field
    /// - Parameter part1: The text that should be inserted in the first text field
    /// - Parameter part2: The text that should be inserted in the second text field
    /// - Parameter part3: The text that should be inserted in the third text field
    /// - Parameter part4: The text that should be inserted in the fourth text field
    /// - Throws: IPError
    public func insertText(part1: String, part2: String, part3: String, part4: String) throws {
        do {
            try self.insertText(at: 0, text: part1)
            try self.insertText(at: 1, text: part2)
            try self.insertText(at: 2, text: part3)
            try self.insertText(at: 3, text: part4)
        } catch {
            self.clear()
            throw error
        }
    }
    
    /// This method inserts text inside the ip address text filed at specified position
    /// - Parameter position: The position of the text field
    /// - Parameter text: The text to be inserted
    /// - Warning: Position starts at 0
    /// - Throws: IPError
    public func insertText(at position: Int, text: String) throws {
        
        // check that the position is valid
        guard position >= 0 && position <= 3 else { throw IPError(type: IPErrorType.invalidPosition) }
        
        // check if only digits are eneterd
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9",]
        guard Set(text).isSubset(of: nums) else { throw IPError(type: IPErrorType.invalidCharacter)}
        
        // check if number is greater than 255
        guard let num = Int(text), num <= 255 else { throw IPError(type: .invalidNumber)}
        
        // insert
        self.textFields[position].text = text
    }
    
    // MARK: - Clear
    
    /// This method clears all text from the ip address text field
    public func clear() {
        for (index,_) in self.textFields.enumerated() {
            self.clearPrivate(position: index)
        }
    }
    
    /// This method clears all text from the ip address text field at the given positions
    /// - Parameter position: The position of the text field
    /// - Throws IPError
    public func clear(at position: Int) throws {
        // check that the position is valid
        guard position >= 0 && position <= 3 else { throw IPError(type: IPErrorType.invalidPosition) }
        self.clearPrivate(position: position)
    }
    
    private func clearPrivate(position: Int) {
        self.textFields[position].text = ""
    }
}
