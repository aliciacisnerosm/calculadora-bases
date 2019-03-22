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
        
        let oneDecimal = one.numeralToDecimal()
        let twoDecimal = two.numeralToDecimal()
        
        let sum = oneDecimal + twoDecimal
        
        let sumInBase = Number.convertFromDecimalToBase(num: sum, TargetBase: base)
        
        
        let answer = Number(base: base, numeral: sumInBase, fractionalPart: nil)
        
        return answer
    }
    
    // Subtract two number in a given base between 2 and 16
    func subtractNumbers(one: Number, two: Number, base: Int) -> Number {
        
        let oneDecimal = one.numeralToDecimal()
        let twoDecimal = two.numeralToDecimal()
        
        let subtraction = oneDecimal - twoDecimal
        
        let subtractionInBase = Number.convertFromDecimalToBase(num: subtraction, TargetBase: base)
        
        let answer = Number(base: base, numeral: subtractionInBase, fractionalPart: nil)
        
        return answer
    }
}
