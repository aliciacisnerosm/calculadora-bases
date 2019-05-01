//
//  OperationData.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 4/30/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit


class OperationData: NSObject {
    
    var functionName: String!
    var params: [String] = []
    
    func setFunctionName(f: String) {
        self.functionName = f
    }
    
    func setParams(p: [String]) {
        self.params = p
    }
    
    
}
