//
//  UserSettings.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 5/2/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class UserSettings: NSObject {
    
    static let defaults = UserDefaults.standard
    
    static func getLang() -> String {
        let language : String = (defaults.value(forKey: "lang") as? String)!
        return language
    }
}
