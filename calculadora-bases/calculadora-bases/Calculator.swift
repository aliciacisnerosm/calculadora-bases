//
//  Calculator.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 3/21/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class Calculator: NSObject {
    
    var history: HistoryManager
    let operationsAvailable = ["addition", "subtraction", "convertBase", "diminished radix complement",
    "radix complement"]
	
	// Add two numbers in a given base between 2 and 16
    func addNumbers(one: Number, two: Number, base: Int, saveOp: Bool = true) -> Number {
		let oneDecimal = Double(one.integralPartToDecimal()) + one.fractionalPartToDecimal()
		let twoDecimal = Double(two.integralPartToDecimal()) + two.fractionalPartToDecimal()
		
		let sum = oneDecimal + twoDecimal
        
		let operation = Number.convertFromDecimalToBase(num: sum, targetBase: base)
		let answer = Number(base: base, integralPart: operation[0]!, fractionalPart: operation[1])
		
        if saveOp {
            history.saveOperation(numbers: [one, two, answer], operation: " + ",
                                  opData: [operationsAvailable[0], String(base), HistoryFormatter.formatNumber(num: one), HistoryFormatter.formatNumber(num: two), HistoryFormatter.formatNumber(num: answer)])
        }
        
		return answer
	}
	
	// Subtract two number in a given base between 2 and 16
    func subtractNumbers(one: Number, two: Number, base: Int, saveOp: Bool = true) -> Number {
		let oneDecimal = Double(one.integralPartToDecimal()) + one.fractionalPartToDecimal()
		let twoDecimal = Double(two.integralPartToDecimal()) + two.fractionalPartToDecimal()
		
		let subtraction = oneDecimal - twoDecimal
        
		let operation = Number.convertFromDecimalToBase(num: subtraction, targetBase: base)
		let answer = Number(base: base, integralPart: operation[0]!, fractionalPart: operation[1])
        
        if saveOp {
            history.saveOperation(numbers: [one, two, answer], operation: " - ",
                                  opData: [operationsAvailable[1], String(base), HistoryFormatter.formatNumber(num: one), HistoryFormatter.formatNumber(num: two), HistoryFormatter.formatNumber(num: answer)])
        }
        
		return answer
	}
	
	// Convert number to another base
    func convertBase(one: Number, base: Int, saveOp: Bool = true) -> Number  {
		let oneDecimal = Double(one.integralPartToDecimal()) + one.fractionalPartToDecimal()
		let cBase = Number.convertFromDecimalToBase(num: oneDecimal, targetBase: base)
		let answer = Number(base: base, integralPart: cBase[0]!, fractionalPart: cBase[1])
        
        /*history.saveOperation(numbers: [one, answer], operation: " -> ",
                              opData: [operationsAvailable[2], String(one.base), String(base)])*/
        
		return answer
	}
    
    // Get the diminished radix complement of a number in any base.
    func getDiminishedRadixComplement(num: Number, saveOp: Bool = true) -> Number {
        
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
        
        let diminishedRadixComplement = self.subtractNumbers(one: baseBeta, two: num, base: num.base, saveOp: false)
        
        if saveOp {
            history.saveOperation(numbers: [num, diminishedRadixComplement], operation: " -> ",
                                  opData: [operationsAvailable[3], String(num.base), HistoryFormatter.formatNumber(num: num), HistoryFormatter.formatNumber(num: diminishedRadixComplement)])
        }
        
        return diminishedRadixComplement
    }
    
    // Get the radix complement of a number in any base.
    func getRadixComplement(num: Number, saveOp: Bool = true) -> Number {
        let radixComplement = self.getDiminishedRadixComplement(num: num, saveOp: false)
        let numberOne = Number(base: num.base, integralPart: "1", fractionalPart: nil)
        
        if saveOp {
            history.saveOperation(numbers: [num, radixComplement], operation: " -> ",
                                  opData: [operationsAvailable[4], String(num.base), HistoryFormatter.formatNumber(num: num), HistoryFormatter.formatNumber(num: self.addNumbers(one: radixComplement, two: numberOne, base: radixComplement.base, saveOp: false))])
        }
        
        return self.addNumbers(one: radixComplement, two: numberOne, base: num.base, saveOp: false)
    }
    
    init(history: HistoryManager) {
        self.history = history
    }
    
}
