//
//  HistoryManager.swift
//  calculadora-bases
//
//  Created by Alicia Cisneros  on 4/8/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class HistoryManager: NSObject {

    var arrayHM :NSMutableArray!
    var paramsArray = [OperationData]()
    var maxStorage : Int = 30
    
     init(arrayHM: NSMutableArray) {
        self.arrayHM = arrayHM
    }
    
    func dataFilePath() -> String {
        let url = FileManager().urls(for: .documentDirectory,
                                     in: .userDomainMask).first!
        let pathArchivo =
            url.appendingPathComponent("history.plist")
        return pathArchivo.path
    }

    func loadData() -> NSMutableArray{
        let arreglo = NSMutableArray(contentsOfFile: dataFilePath())
        return arreglo!
    }
    
    func saveData(sEquals : String, opData: [String]) {
        if self.arrayHM.count == maxStorage {
            self.arrayHM.removeObject(at: 0)
        }
        
        self.arrayHM.add(sEquals)
        self.arrayHM.write(toFile: dataFilePath(), atomically: true)
        
        if self.paramsArray.count == maxStorage {
            self.paramsArray.remove(at: 0)
        }
        
        let operation = OperationData()
        operation.setFunctionName(f: opData[0])
        operation.setParams(p: Array(opData[0..<opData.count]))
        self.paramsArray.append(operation)
        
    }
    
    func saveOperation(numbers: [Number], operation: String, opData: [String]) {
        var equationToStore : String = ""
        
        if opData[0] == "addition" || opData[0] == "subtraction" {
            equationToStore = HistoryFormatter.formatOperations(num1: numbers[0], num2: numbers[1], operation: operation)
        }
        
        equationToStore += " = " + HistoryFormatter.formatNumber(num: numbers[numbers.count - 1])
        
        self.saveData(sEquals: equationToStore, opData: opData)
    }

}
