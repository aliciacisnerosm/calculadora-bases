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
}
