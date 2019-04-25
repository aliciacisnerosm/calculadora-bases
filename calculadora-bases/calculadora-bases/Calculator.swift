//
//  Calculator.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 3/21/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class Calculator: NSObject {
    
    func countDigits(num: Int) -> Int {
        var n = num
        var count = 0
        while n > 0 {
            n /= 10
            count += 1
        }
        return count
    }
    
    func sumFractions(one: Int, two: Int) -> [Int] {
        let oneDigits = countDigits(num: one)
        let twoDigits = countDigits(num: two)
        let maxNumDigits = oneDigits > twoDigits ? oneDigits : twoDigits
        
        var carry: Int
        var answer = one + two
        
        if countDigits(num: answer) > maxNumDigits {
            carry = 1
            var numInString = ""
            for _ in 1...(countDigits(num: answer) - 1) {
                numInString = String(answer % 10) + numInString
                answer /= 10
            }
        } else {
            carry = 0
        }
        
        return [carry, answer]
    }
    
    func subtractFractions(one: Int, two: Int) -> [Int] {
        let oneDigits = countDigits(num: one)
        let twoDigits = countDigits(num: two)
        var answer: Int
        var carry: Int
        
        if oneDigits > twoDigits {
            answer = one - Int(pow(Double(two), Double(oneDigits - twoDigits)))
        } else if twoDigits > oneDigits {
            answer = Int(pow(Double(one), Double(twoDigits - oneDigits))) - two
        } else {
            answer = one - two
        }
        
        if answer < 0 {
            answer *= -1
            carry = 1
        } else {
            carry = 0
        }
        
        return [carry, answer]
    }
	
	// Add two numbers in a given base between 2 and 16
	func addNumbers(one: Number, two: Number, base: Int) -> Number {
        
		let oneDecimal = one.integralPartToDecimal()
		let twoDecimal = two.integralPartToDecimal()
        
        let fracPart = self.sumFractions(one: one.fractionalPartToDecimal(), two: two.fractionalPartToDecimal())
		
        let sum: Int = oneDecimal + twoDecimal + fracPart[0]
        
        let fractionToBase = Number.fractionalToBase(num: Double(fracPart[1]), targetBase: base)
        
		let operation = Number.convertFromDecimalToBase(num: sum, targetBase: base)
		let answer = Number(base: base, integralPart: operation, fractionalPart: fractionToBase)
		
		return answer
	}
	
	// Subtract two number in a given base between 2 and 16
	func subtractNumbers(one: Number, two: Number, base: Int) -> Number {
		let oneDecimal = one.integralPartToDecimal()
		let twoDecimal = two.integralPartToDecimal()
		
        let fracPart = self.subtractFractions(one: one.fractionalPartToDecimal(), two: two.fractionalPartToDecimal())
        
        let subtraction : Int = oneDecimal - twoDecimal - fracPart[0]
        
        let fractionToBase = Number.fractionalToBase(num: Double(fracPart[1]), targetBase: base)
        
		let operation = Number.convertFromDecimalToBase(num: subtraction, targetBase: base)
		let answer = Number(base: base, integralPart: operation, fractionalPart: fractionToBase)
		
		return answer
	}
	
	// Convert number to another base
	func convertBase(one: Number, base: Int) -> Number  {
        let oneDecimal : Int = one.integralPartToDecimal()
        let fracPart : Int = one.fractionalPartToDecimal()
        let fractionToBase = Number.fractionalToBase(num: Double(fracPart), targetBase: base)
        
		let cBase = Number.convertFromDecimalToBase(num: oneDecimal, targetBase: base)
		let answer = Number(base: base, integralPart: cBase, fractionalPart: fractionToBase)
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
