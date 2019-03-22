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
    
    // Number base in which the number operates.
    var base: Int!
    // The number itself.
    var numeral: String!
    var fractionalPart: String?
    let letterNums = ["A": 10, "B": 11, "C": 12,
                      "D": 13, "E": 14, "F": 15]
    
    func getNumeral() -> String {
        return self.numeral
    }
    
    // Convert the numeral part to decimal
    func numeralToDecimal() -> Int {
        if base == 10 { return Int(self.numeral)! }

        // Reverse the order of the number to start at position 0.
        let reverseNumber = String(self.numeral.reversed())
        let digits = CharacterSet.decimalDigits
        
        var position = 0
        var decimalAnswer = 0
        
        // Convert to unicode scalars to check if they are member of digits.
        for num in reverseNumber.unicodeScalars {
            var intNum: Int
            
            if digits.contains(num) {
                intNum = Int(String(num))!
            } else {
                intNum = self.letterNums[String(num)]!
            }
            
            // Converting intNum to decimal by using number * base ^ position.
            decimalAnswer = decimalAnswer + Int((Double(intNum) * pow(Double(self.base), Double(position))))
            position = position + 1
        }
        
        return decimalAnswer
    }
    
    
    static func convertFromDecimalToBase(num: Int, TargetBase: Int) -> String {

        var newNumber: String = String()
        var varNum = num
        
        while(varNum != 0){
            let remainder = varNum % TargetBase
            newNumber.append(String(remainder))
            
            varNum = varNum / TargetBase
        }
        
        if newNumber.isEmpty {
            newNumber = "0"
        }else {
            newNumber = String(newNumber.reversed())
        }
        
        return newNumber
    }
    
    init(base: Int, numeral: String, fractionalPart: String?) {
        self.base = base
        self.numeral = numeral
    }

}
