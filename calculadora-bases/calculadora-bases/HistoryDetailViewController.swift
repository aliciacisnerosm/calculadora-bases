//
//  HistoryDetailViewController.swift
//  calculadora-bases
//
//  Created by Arturo Torres on 4/30/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
    
    @IBOutlet weak var lblFirstNum: UILabel!
    @IBOutlet weak var lblSecondNum: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblOperation: UILabel!
    @IBOutlet weak var lblOperatorSign: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblCarry: UILabel!
    
    var operation: String!
    var firstNum: String!
    var secondNum: String!
    var base: String!
    var operatorSign: String!
    var answer: String!
    var carry: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch operation {
            
        case "addition", "subtraction":
            viewForAddAndSub()
        default:
            viewForComplements()
        }
        
    }
    
    func viewForComplements() {
        lblFirstNum.text = firstNum
        lblAnswer.text = answer
        lblCarry.text = ""
        lblSecondNum.text = ""
        lblOperatorSign.text = operatorSign
        lblOperation.text = operation
    }
    
    func viewForAddAndSub() {
        let firstLen = firstNum.count
        let secondLen = secondNum.count
        
        lblOperation.text = operation
        
        if operation == "addition" && firstLen < secondLen {
            lblFirstNum.text = secondNum
            lblSecondNum.text = firstNum
        } else {
            lblFirstNum.text = firstNum
            lblSecondNum.text = secondNum
        }
        
        lblBase.text = base
        lblOperatorSign.text = operatorSign
        lblAnswer.text = answer
        
        calculateCarry()
        lblCarry.text = carry
    }
    
    // For addition
    func calculateCarry() {
        switch operation {
        case "addition":
            carryAddition()
        case "subtraction":
            print("subtraction")
        default:
            print("Invalid operation")
            
        }
    }
    
    func carryAddition() {
        let f = String(lblFirstNum.text!.reversed()).unicodeScalars
        let s = String(lblSecondNum.text!.reversed()).unicodeScalars
        carry = "0"
        for i in 0..<s.count {
            let idx = s.index(s.startIndex, offsetBy: i)
            let sNum = Number.convertStringDigitToInt(digit: s[idx])
            let fNum = Number.convertStringDigitToInt(digit: f[idx])
            let carryNum = Number.convertStringDigitToInt(digit: carry.unicodeScalars[idx])
            
            if sNum + fNum + carryNum >= Int(base)! {
                carry.append("1")
            } else {
                carry.append("0")
            }
            
        }
        
        for _ in s.count..<f.count {
            carry.append("0")
        }
        
        carry = String(carry.reversed())
    }
    
    func carrySubtraction() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
