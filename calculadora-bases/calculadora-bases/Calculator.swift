//
//  Calculator.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 3/21/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class Calculator: NSObject {
	
	// Add two numbers in a given base between 2 and 16
	func addNumbers(one: Number, two: Number, base: Int) -> Number {
		let oneDecimal = one.integralPartToDecimal()
		let twoDecimal = two.integralPartToDecimal()
		
		let sum = oneDecimal + twoDecimal
		let sumInBase = Number.convertFromDecimalToBase(num: sum, targetBase: base)
		let answer = Number(base: base, integralPart: sumInBase, fractionalPart: nil)
		
		return answer
	}
	
	// Subtract two number in a given base between 2 and 16
	func subtractNumbers(one: Number, two: Number, base: Int) -> Number {
		let oneDecimal = one.integralPartToDecimal()
		let twoDecimal = two.integralPartToDecimal()
		
		let subtraction = oneDecimal - twoDecimal
		let subtractionInBase = Number.convertFromDecimalToBase(num: subtraction, targetBase: base)
		let answer = Number(base: base, integralPart: subtractionInBase, fractionalPart: nil)
		
		return answer
	}
	
	// Convert number to another base
	func convertBase(one: Number, base: Int) -> Number  {
		let oneDecimal = one.integralPartToDecimal()
		let cBase = Number.convertFromDecimalToBase(num: oneDecimal, targetBase: base)
		let answer = Number(base: base, integralPart: cBase, fractionalPart: nil)
		return answer
	}
    
    // Get the diminished radix complement of a number in any base.
    func getDiminishedRadixComplement(num: Number) -> Number {
        
        let numberOfDigits = num.integralPart.count
        var maxDigit = String(num.base - 1)
        
        switch maxDigit {
            case "10": maxDigit = "A"
            case "11": maxDigit = "B"
            case "12": maxDigit = "C"
            case "13": maxDigit = "D"
            case "14": maxDigit = "E"
            case "15": maxDigit = "F"
            default: print("No decimal to letter conversion needed.")
        }
        
        let n = String(repeating: maxDigit, count: numberOfDigits)
        let baseBeta = Number(base: num.base, integralPart: n, fractionalPart: nil)
        
        let diminishedRadixComplement = self.subtractNumbers(one: baseBeta, two: num, base: num.base)
        
        return diminishedRadixComplement
    }
    
    // Get the radix complement of a number in any base.
    func getRadixComplement(num: Number) -> Number {
        let radixComplement = self.getDiminishedRadixComplement(num: num)
        let numberOne = Number(base: num.base, integralPart: "1", fractionalPart: nil)
        return self.addNumbers(one: radixComplement, two: numberOne, base: num.base)
    }
    
}
