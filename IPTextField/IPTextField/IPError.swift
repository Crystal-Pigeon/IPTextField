//
//  IPError.swift
//  IPTextField
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import Foundation

public enum IPErrorType: String {
    
    case invalidPosition = "Position must be between 0 and 3"
    case invalidCharacter = "Only digits are allowed"
    case invalidNumber = "Value can not be greater than 255"
}

class IPError: NSObject, LocalizedError {
        
    var type: IPErrorType
    
    init(type: IPErrorType) {
        self.type = type
    }
    
    override var description: String {
        get {
            return type.rawValue
        }
    }
    
    var errorDescription: String? {
        get {
            return self.description
        }
    }
}
