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
    
    func getFractionalPart() -> String? {
        return fractionalPart
    }
	
	// MARK -- Converts integer part to base 10.
	func integralPartToDecimal() -> Int {
		// Just return the number if its base is already 10
		if base == 10 { return Int(self.integralPart)! * (self.isNegative ? -1 : 1) }
		
		// Reverse the order of the number to start at position 0.
		let reverseNumber = String(self.integralPart.reversed())
		var positionalExponent = 0
		var decimalAnswer = 0
		
		// Convert to unicode scalars to check if they are member of digits.
		for num in reverseNumber.unicodeScalars {
			let intNum: Int = Number.convertStringDigitToInt(digit: num)
			// Converting intNum to decimal by using number * base ^ position.
			decimalAnswer += intNum * Int(pow(Double(self.base), Double(positionalExponent)))
			positionalExponent += 1
		}
		
		// Turn number to negative if necessary
		decimalAnswer *= (self.isNegative ? -1 : 1)
		
		return decimalAnswer
	}
    
    // MARK -- Converts the fractional part to base 10
    func fractionalPartToDecimal() -> Double {
        
        guard let hasFraction = self.fractionalPart else { return 0 }
        
        var positionalExponent = -1
        var decimalAnswer: Double = 0.0
        
        for num in hasFraction.unicodeScalars {
            let intNum: Int = Number.convertStringDigitToInt(digit: num)
            // Converting intNum to decimal by using number * base ^ position.
            decimalAnswer += Double(intNum) * Double(pow(Double(self.base), Double(positionalExponent)))
            positionalExponent -= 1
        }
        
        while decimalAnswer >= 1.0 {
            decimalAnswer /= 10.0
        }
        
        return decimalAnswer
    }
    
    static func convertStringDigitToInt(digit : Unicode.Scalar) -> Int {
        var num: Int = 0
        let digits = CharacterSet.decimalDigits
        
        if digits.contains(digit) {
            num = Int(String(digit))!
        } else if letterToNumber[String(digit)] != nil {
            num = Number.letterToNumber[String(digit)]!
        }
        
        return num
    }
    
    // MARK -- Converts the fractional part of a number form base 10 to base 'targetBase'.
    // Receives a fractional number less than 1 (0.xxxxx).
    static func fractionalToBase(num: Double, targetBase: Int) -> String? {
        var fractional: String = ""
        var numMut = num
        // Will only have 8 decimal places.
        for _ in 1...8 {
            numMut *= Double(targetBase)
            let addNum = Int(floor(numMut))
            let strNum : String
            
            if addNum >= 10 {
                strNum = self.numberToLetter[addNum]!
            } else {
                strNum = String(addNum)
            }
            fractional.append(strNum)
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
	static func convertFromDecimalToBase(num: Double, targetBase: Int) -> [String?] {
        var varNum = num < 0 ? Int(ceil(num)) : Int(floor(num))
		var negativeNumber = false
		var newNumber = ""
		
		if num < 0 {
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
		
		newNumber = (newNumber.isEmpty ? "0" : String(newNumber.reversed()))
        
        if negativeNumber {
            newNumber = "-" + newNumber
        }
        
        let fractionalPart = num < 0 ? (num * -1.0) - (floor(num * -1.0)) : num - floor(num)
        let newFractionalNumber = self.fractionalToBase(num: fractionalPart, targetBase: targetBase)
		
		return [newNumber, newFractionalNumber]
	}
	
	// Return a formatted string
	func stringFormat() -> String {
		var string = (isNegative ? "-" : "") + integralPart
		
		if let fraction = fractionalPart {
			string += "." + fraction
		}
		
		return string
	}
	
	// MARK: - Initializer
	init(base: Int, integralPart: String, fractionalPart: String?) {
		self.base = base
		self.integralPart = integralPart
		self.fractionalPart = fractionalPart
		self.isNegative = false
		
		// Remove '-' sign
		if self.integralPart.first == "-" {
			let start = integralPart.index(integralPart.startIndex, offsetBy: 1)
			let end = integralPart.index(integralPart.endIndex, offsetBy: 0)
			let range = start..<end
			
			let substr = integralPart[range]
			self.integralPart = String(substr)
			self.isNegative = true
		}
	}
}
