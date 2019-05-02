//
//  HistoryFormatter.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 4/30/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class HistoryFormatter: NSObject {
    
    static func formatNumber(num: Number) -> String {
        return num.getIntegralPart() + (num.getFractionalPart() == nil ? "" : "." + num.getFractionalPart()!)
    }
    
    static func formatOperations(num1: Number, num2: Number, operation: String) -> String {
        var equationToStore : String
        
        equationToStore = formatNumber(num: num1) + " \(operation) " + formatNumber(num: num2)
        
        return equationToStore
    }

}
