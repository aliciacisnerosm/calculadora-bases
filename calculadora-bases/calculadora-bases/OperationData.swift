//
//  OperationData.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 4/30/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit


class OperationData: NSObject, Codable {
    
    var functionName: String = ""
    var params: [String] = []
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveOpsURL = documentsDirectory.appendingPathComponent("OperationsData")
    
    enum CodingKeys: String, CodingKey {
        case functionName
        case params
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(functionName, forKey: .functionName)
        try container.encode(params, forKey: .params)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        functionName = try container.decode(String.self, forKey: .functionName)
        params = try container.decode([String].self, forKey: .params)
    }
    
    
    func setFunctionName(f: String) {
        self.functionName = f
    }
    
    func getFunctionName()->String{
        return functionName
    }
    
    func setParams(p: [String]) {
        self.params = p
    }
    
    override init() {
        self.functionName = ""
        self.params = []
    }
    
    
}
