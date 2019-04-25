//
//  Number.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 3/21/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

// Class that handles numbers in different bases.

import UIKit

class Number: NSObject {
	var base: Int!										// Number base in which the number operates
	var integralPart: String!					// Integer part of the number
	var fractionalPart: String?				// Decimal part of the number
	var isNegative: Bool!							// Determines if number is negative or not
	
	static let letterToNumber = ["A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15]
	static let numberToLetter = [10: "A", 11: "B", 12: "C", 13: "D", 14: "D", 15: "F"]
	
	// MARK -- Gets the integer part.
	func getIntegralPart() -> String {
		return (isNegative ? "-" : "") + self.integralPart
	}
	
	// MARK -- Converts integer part to base 10.
	func integralPartToDecimal() -> Int {
		// Just return the number if its base is already 10
		if base == 10 { return Int(self.integralPart)! }
		
		// Reverse the order of the number to start at position 0.
		let reverseNumber = String(self.integralPart.reversed())
		let digits = CharacterSet.decimalDigits
		var positionalExponent = 0
		var decimalAnswer = 0
		
		// Convert to unicode scalars to check if they are member of digits.
		for num in reverseNumber.unicodeScalars {
			var intNum: Int
			
			if digits.contains(num) {
				intNum = Int(String(num))!
			} else {
				intNum = Number.letterToNumber[String(num)]!
			}
			
			// Converting intNum to decimal by using number * base ^ position.
			decimalAnswer += intNum * Int(pow(Double(self.base), Double(positionalExponent)))
			positionalExponent += 1
		}
		
		// Turn number to negative if necessary
		decimalAnswer *= (self.isNegative ? -1 : 1)
		
		return decimalAnswer
	}
    
    // MARK -- Converts the fractional part to base 10
    func fractionalPartToDecimal() -> Int {
        
        guard let hasFraction = self.fractionalPart else { return 0 }
        if base == 10 { return Int(hasFraction)! }
        
        let digits = CharacterSet.decimalDigits
        var positionalExponent = -1
        var decimalAnswer: Int = 0
        
        for num in hasFraction.unicodeScalars {
            var intNum: Int
            
            if digits.contains(num) {
                intNum = Int(String(num))!
            } else {
                intNum = Number.letterToNumber[String(num)]!
            }
            
            // Converting intNum to decimal by using number * base ^ position.
            decimalAnswer += intNum * Int(pow(Double(self.base!), Double(positionalExponent)))
            positionalExponent -= 1
        }
        
        return decimalAnswer
    }
    
    // MARK -- Converts the fractional part of a number form base 10 to base 'targetBase'.
    // Receives a fractional number less than 1 (0.xxxxx).
    static func fractionalToBase(num: Double, targetBase: Int) -> String? {
        var fractional: String = ""
        var numMut = num
        // Will only have 8 decimal places.
        for _ in 1...8 {
            numMut *= Double(targetBase)
            fractional.append(String(Int(floor(numMut))))
            numMut -= floor(numMut)
        }
        
        var hasAllZeros: Bool = true
        for digit in fractional {
            if digit != "0" {
                hasAllZeros = false
            }
        }
        
        return hasAllZeros ? nil : fractional
    }
	
	// MARK -- Converts a number from base 10 to base `targetBase`.
	static func convertFromDecimalToBase(num: Int, targetBase: Int) -> String {
		var varNum = num
		var negativeNumber = false
		var newNumber = ""
		
		if varNum < 0 {
			negativeNumber = true
			varNum *= -1
		}
		
		while (varNum != 0) {
			let remainder = varNum % targetBase
			
			if let hasDigitBiggerThanTen = Number.numberToLetter[remainder] {
				newNumber.append(hasDigitBiggerThanTen)
			} else {
				newNumber.append(String(remainder))
			}
			
			varNum = varNum / targetBase
		}
		
		if negativeNumber {
			newNumber.append("-")
		}
		
		newNumber = (newNumber.isEmpty ? "0" : String(newNumber.reversed()))
		
		return newNumber
	}
	
	// MARK: - Initializer
	init(base: Int, integralPart: String, fractionalPart: String?) {
		self.base = base
		self.integralPart = integralPart
        self.fractionalPart = fractionalPart
		self.isNegative = false
		
		// Remove '-' sign
		if self.integralPart[integralPart.startIndex] == "-" {
			let start = integralPart.index(integralPart.startIndex, offsetBy: 1)
			let end = integralPart.index(integralPart.endIndex, offsetBy: 0)
			let range = start..<end
			
			let substr = integralPart[range]
			self.integralPart = String(substr)
			self.isNegative = true
		}
	}
}
