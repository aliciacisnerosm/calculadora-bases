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
    
    func saveData(arregloHistory: NSMutableArray, sEquals : String) -> NSMutableArray{
        if arregloHistory.count == 9 {
            arregloHistory.removeObject(at: 0)
        }
        arregloHistory.add(sEquals)
        
        arregloHistory.write(toFile: dataFilePath(), atomically: true)
        
        return arregloHistory
    }
}
