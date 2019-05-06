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
    
    var op : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserSettings.getLang() == "spanish" {
            stepsOperationSpanish()
        } else {
            stepsOperationEnglish()
        }
        
        // Do any additional setup after loading the view.
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    func stepsOperationSpanish() {
        
        if(op == "suma"){
            lbOne?.text = "1. Alinea los números de derecha a izquierda. Si un número es más corto, extiéndalo agregando ceros a la parte delantera del número más corto "
            lbSTwo?.text = "2. Trabaje de derecha a izquierda: realice la misma operación de suma y carga en cada columna."
            lbSThree?.text = "3. Add the two digits in the same column and also add the carry at the top of the column (if any)."
            lbSFour?.text = "4. Agregue los dos dígitos en la misma columna y también agregue el acarreo en la parte superior de la columna (si corresponde)."
            lbFive?.text = "5. Una respuesta de dos dígitos requiere que reste 10 de la suma y registre el resto en la parte inferior de la misma columna."
            lbSSix?.text = "6. Una respuesta de dos dígitos también requiere que registre un acarreo de 1 en la siguiente columna a la izquierda y cualquier acarreo adicional se registra en una nueva columna a la izquierda."
        } else if(op == "resta"){
            
            lbOne?.text = "1. Alinea los números de derecha a izquierda. Si un número es más corto, extiéndalo agregando ceros al principio del número."
            lbSTwo?.text = "2. Trabaje de derecha a izquierda: realice la misma operación de resta y préstamo en cada columna. "
            lbSThree?.text = "3. Reste los dos dígitos en la misma columna y también reste el préstamo en la parte superior de la columna (si corresponde). Puede obtener una respuesta negativa. Esto está bien, no tome prestado un diez para evitar la respuesta negativa, solo haga la aritmética firmada."
            lbSFour?.text = "4. Si la diferencia es positiva o cero, simplemente anótela en la parte inferior de la columna y registre un préstamo 0 en la siguiente columna a la izquierda. "
            lbFive?.text = "5.Si la diferencia es negativa, agregue 10 y registre el resultado (que ya no será negativo) en la parte inferior de la columna. También registra un préstamo 1 en la siguiente columna a la izquierda."
            lbSSix?.text = " "
            
        }else{
            
            lbOne?.text = "1. Identifica la base en la que esta el número"
            lbSTwo?.text = "2.-Identifica el digito con mayor valor del sistema numerico y restalo a cada digito de número inicial"
            lbSThree?.text = "3. Si el número inicial contiene 3 digito y el digito con más valor es 7, resta 777 - número inicial "
            lbSFour?.text = "4. Para encontrar el complemento, agrega 1 a la resta anterior"
            lbFive.isHidden = true
            lbSSix.isHidden = true
            
        }
    }
    
    func stepsOperationEnglish(){
        print("hello")
        print(op)
        if(op == "addition"){
            lbOne.isHidden = false
            lbSTwo.isHidden = false
            lbSThree.isHidden = false
            lbSFour.isHidden = false
            lbFive.isHidden = false
            lbSSix.isHidden = false
            lbOne?.text = "1.  Line up the numbers from right to left. If one number is shorter, extend it by adding leading zeros to the front of the shorter number."
            lbSTwo?.text = "2. Work from right to left - doing the same addition and carry operation in each column."
            lbSThree?.text = "3. Add the two digits in the same column and also add the carry at the top of the column (if any)."
            lbSFour?.text = "4. A one digit answer is simply recorded at the bottom of the same column."
            lbFive?.text = "5. A two digit answer requires you to subtract 10 from the sum and record the remainder at the bottom of the same column."
            lbSSix?.text = "6. A two digit answer also requires you to record a carry of 1 in the next column over to the left & any extra carry is recorded in a new column on the left."
        }
        if(op == "subtraction"){
            lbOne.isHidden = false
            lbSTwo.isHidden = false
            lbSThree.isHidden = false
            lbSFour.isHidden = false
            lbFive.isHidden = false
            lbSSix.isHidden = false
            lbOne?.text = "1. Line up the numbers from right to left. If one number is shorter extend it by adding leading zeros to the front of the number."
            lbSTwo?.text = "2. Work from right to left - doing the same subtraction and borrow operation in each column. "
            lbSThree?.text = "3. Subtract the two digits in the same column and also subtract the borrow at the top of the column (if any). You may get a negative answer. This is OK, do not borrow a ten to avoid the negative answer - just do the signed arithmetic."
            lbSFour?.text = "4. If the difference is positive or zero - then just record it at the bottom of the column and record a borrow 0 in the next column left. "
            lbFive?.text = "5. If the difference is negative - then add 10 to it and record the result (which will no longer be negative) at the bottom of the column. Also record a borrow 1 in the next column left."
            lbSSix?.text = " "
            
        }else{
            lbOne?.text = "1. Identify the base or radix"
            lbSTwo?.text = "2. Identify the largest digit in the numeric system and subtract each digit of the given number to the largest digit. if the number its a 3 digit number & the largest number is 7, subtract the number from 777"
            lbSThree?.text = "3. If the number its a 3 digit number & the largest number is 7, subtract the number from 777"
            lbSFour?.text = "4. To find r's complement add 1 to th result of the subtraction"
            lbFive.isHidden = true
            lbSSix.isHidden = true
        }
    }
}
