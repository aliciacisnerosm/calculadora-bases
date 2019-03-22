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
	@IBOutlet weak var lbTopNum: UILabel!
	@IBOutlet weak var lbBottomNum: UILabel!
	
	let calc = Calculator()
	var topNum = Number(base: 10, integralPart: "0", fractionalPart: nil)
	var bottomNum = Number(base: 10, integralPart: "0", fractionalPart: nil)
	var activeOperation = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func typeNumber(_ sender: UIButton) {
		let ch: Character!
		
		if sender.tag < 10 {
			ch = Character(String(sender.tag))
		} else {
			ch = Character(Number.numberToLetter[sender.tag]!)
		}
		
		if (lbTopNum.text == "0") {
			lbTopNum.text = String(ch)
		} else {
			lbTopNum.text?.append(ch)
		}
	}
	
	@IBAction func clear(_ sender: UIButton) {
		topNum = Number(base: 10, integralPart: "0", fractionalPart: nil)
		lbTopNum.text = topNum.getIntegralPart()
		
		if sender.tag == 1 {
			bottomNum = Number(base: 10, integralPart: "0", fractionalPart: nil)
			lbBottomNum.text = bottomNum.getIntegralPart()
			activeOperation = 0
		}
	}
	
	@IBAction func operation(_ sender: UIButton) {
		topNum = Number(base: 10, integralPart: lbTopNum.text!, fractionalPart: nil)
		
		switch activeOperation {
		case 0:		// Equal
			if topNum.getIntegralPart() != "0" {
				bottomNum = topNum
			}
			break
		case 1:		// Sum
			bottomNum = calc.addNumbers(one: bottomNum, two: topNum, base: 10)
			break
		case 2:		// Subtract
			bottomNum = calc.subtractNumbers(one: bottomNum, two: topNum, base: 10)
			break
		default: break	// No active operation
		}
		
		topNum = Number(base: 10, integralPart: "0", fractionalPart: nil)
		lbTopNum.text = topNum.getIntegralPart()
		lbBottomNum.text = bottomNum.getIntegralPart()
		activeOperation = sender.tag
	}
}

