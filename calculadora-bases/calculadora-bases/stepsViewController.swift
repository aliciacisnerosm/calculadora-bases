//
//  stepsViewController.swift
//  calculadora-bases
//
//  Created by Alicia Cisneros  on 5/1/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class stepsViewController: UIViewController {
    
    @IBOutlet weak var lbOne: UILabel!
    @IBOutlet weak var lbSTwo: UILabel!
    @IBOutlet weak var lbSThree: UILabel!
    @IBOutlet weak var lbSFour: UILabel!
    @IBOutlet weak var lbFive: UILabel!
    @IBOutlet weak var lbSSix: UILabel!
    
    var op = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        sOperation()
        // Do any additional setup after loading the view.
    }
    
    func sOperation(){

            lbOne?.text = "1.  Line up the numbers from right to left. If one number is shorter, extend it by adding leading zeros to the front of the shorter number."
            lbSTwo?.text = "2. Work from right to left - doing the same addition and carry operation in each column."
            lbSThree?.text = "3. Add the two digits in the same column and also add the carry at the top of the column (if any)."
            lbSFour?.text = "4. A one digit answer is simply recorded at the bottom of the same column."
            lbFive?.text = "5. A two digit answer requires you to subtract 10 from the sum and record the remainder at the bottom of the same column."
            lbSSix?.text = "6. A two digit answer also requires you to record a carry of 1 in the next column over to the left & any extra carry is recorded in a new column on the left."
        
// substraction
/*
         lbOne?.text = "1. Line up the numbers from right to left. If one number is shorter extend it by adding leading zeros to the front of the number.
         lbSTwo?.text = "2. Work from right to left - doing the same subtraction and borrow operation in each column. "
         lbSThree?.text = "3. Subtract the two digits in the same column and also subtract the borrow at the top of the column (if any). You may get a negative answer. This is OK, do not borrow a ten to avoid the negative answer - just do the signed arithmetic."
         lbSFour?.text = "4. If the difference is positive or zero - then just record it at the bottom of the column and record a borrow 0 in the next column left. "
         lbFive?.text = "5. If the difference is negative - then add 10 to it and record the result (which will no longer be negative) at the bottom of the column. Also record a borrow 1 in the next column left."
         lbSSix?.text = " "
 
 
 */
        
    }
    
    
    

}
