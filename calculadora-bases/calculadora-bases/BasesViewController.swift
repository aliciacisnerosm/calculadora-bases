//
//  BasesViewController.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 4/8/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

protocol changeBaseProtocol {
	func convertNumber(base: Int) -> Number
	func changeBaseAndDismiss(num: Number)
}

class BasesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	var delegate: changeBaseProtocol!
	
	@IBOutlet weak var basesPickerView: UIPickerView!
	@IBOutlet weak var btnSelectBase: UIButton!
	
	@IBOutlet weak var lbOriginalBase: UILabel!
	@IBOutlet weak var lbOriginalNum: UILabel!
	@IBOutlet weak var lbConvertedNum: UILabel!
	@IBOutlet weak var lbConvertedBase: UILabel!
	
	let bases = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
	var currentNum = Number(base: 10, integralPart: "0", fractionalPart: nil)
	var convertedNum = Number(base: 10, integralPart: "0", fractionalPart: nil)
	var selectedBase: Int = 2
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.basesPickerView.delegate = self
		self.basesPickerView.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		reloadData()
	}
	
	// Reload data
	func reloadData() {
		convertedNum = delegate.convertNumber(base: selectedBase)
		
		lbOriginalBase.text = "Base " + String(currentNum.base)
		lbOriginalNum.text = currentNum.stringFormat()
		lbConvertedBase.text = "Base " + String(convertedNum.base)
		lbConvertedNum.text = convertedNum.stringFormat()
	}
	
	// MARK: - Picker Delegate
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedBase = bases[row]
		reloadData()
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return bases.count
	}
	
	func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
		
		let rowText = String(bases[row])
		return NSAttributedString(string: rowText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
	}
	
	// MARK: - Navigation
	override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
		if let _ = unwindSegue.destination as? CalculatorViewController {
			delegate.changeBaseAndDismiss(num: convertedNum)
		}
	}
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
