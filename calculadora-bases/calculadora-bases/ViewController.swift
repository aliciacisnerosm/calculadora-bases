//
//  ViewController.swift
//  calculadora-bases
//
//  Created by Alicia Cisneros  on 3/21/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viewCal: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let n = Number(base: 2, numeral: "101", fractionalPart: nil)
        let b = Number(base: 2, numeral: "101", fractionalPart: nil)
        
        let calc = Calculator()
        
        print(n.numeralToDecimal())
        print(b.numeralToDecimal())
        
        let ans = calc.subtractNumbers(one: n, two: b, base: 2)
        print(ans.getNumeral())
        print(ans.numeralToDecimal())
        
    }

}

