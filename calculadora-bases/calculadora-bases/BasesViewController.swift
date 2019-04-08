//
//  BasesViewController.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 4/8/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class BasesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var basesPickerView: UIPickerView!
    @IBOutlet weak var btnSelectBase: UIButton!
    
    let bases = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    var selectedBase: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.basesPickerView.delegate = self
        self.basesPickerView.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBase = bases[row]
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as! UIButton) == btnSelectBase {
            if let mainView = segue.destination as? CalculatorViewController {
                mainView.currentBase = selectedBase
            }
        }
        
    }
 

}
