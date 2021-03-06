//
//  HistoryManager.swift
//  calculadora-bases
//
//  Created by Alicia Cisneros  on 4/8/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class HistoryManager: NSObject {

    var arrayHM :NSMutableArray
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
    
    func storeParamsArray() {
        do {
            let data = try PropertyListEncoder().encode(self.paramsArray)
            try data.write(to: OperationData.archiveOpsURL)
        }
        catch {
            print("Could'nt store params array")
        }
    }
    
    func retrieveParamsArray() -> [OperationData]?{
        do {
            let data = try Data.init(contentsOf: OperationData.archiveOpsURL)
            let paramsTemp = try PropertyListDecoder().decode([OperationData].self, from: data)
            return paramsTemp
        } catch {
            return nil
        }
    }

    func loadData() -> NSMutableArray{
        if let arreglo = NSMutableArray(contentsOfFile: dataFilePath()){
            return arreglo
        }
        return arrayHM
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
        
        self.storeParamsArray()
    }
    
    func saveOperation(numbers: [Number], operation: String, opData: [String]) {
        var equationToStore : String = ""
        
        switch opData[0] {
            
        case "addition", "subtraction", "suma", "resta":
            equationToStore = HistoryFormatter.formatOperations(num1: numbers[0], num2: numbers[1], operation: operation)
        case "diminished radix complement", "complemento disminuido":
            equationToStore = HistoryFormatter.formatNumber(num: numbers[0]) + " -> CD"
        case "radix complement", "complemento":
            equationToStore = HistoryFormatter.formatNumber(num: numbers[0]) + " -> C"
            
        default:
            print("invalid operation")
            
        }
        
        equationToStore += " = " + HistoryFormatter.formatNumber(num: numbers[numbers.count - 1])
        
        self.saveData(sEquals: equationToStore, opData: opData)
    }

}
