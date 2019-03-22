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
		
		let n = Number(base: 16, integralPart: "C", fractionalPart: nil)
		let b = Number(base: 16, integralPart: "FF", fractionalPart: nil)
		let calc = Calculator()
		
		print(n.integralPartToDecimal())
		print(b.integralPartToDecimal())
		
		var ans = calc.subtractNumbers(one: n, two: b, base: 16)
		print(ans.integralPart!)
		print(ans.integralPartToDecimal())
		
		ans = calc.convertBase(one: n, base: 11)
		print(ans.integralPart!)
	}
}

