//
//  stepsViewController.swift
//  calculadora-bases
//
//  Created by Alicia Cisneros  on 5/1/19.
//  Copyright © 2019 Alicia Cisneros. All rights reserved.
//

import UIKit

class stepsViewController: UIViewController {
	@IBOutlet weak var lbSteps: UILabel!
	
	var op : String = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if UserSettings.getLang() == "spanish" {
			stepsOperationSpanish()
		} else {
			stepsOperationEnglish()
		}
	}
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return UIInterfaceOrientationMask.landscape
	}
	override var shouldAutorotate: Bool {
		return false
	}
	
	func stepsOperationSpanish() {
		if op == "suma" {
			lbSteps.text =
			"""
			1. Alinea los números de derecha a izquierda. Si un número es más corto, extiéndalo agregando ceros a la parte delantera del número más corto.
			2. Trabaje de derecha a izquierda: realice la misma operación de suma y carga en cada columna.
			3. Add the two digits in the same column and also add the carry at the top of the column (if any).
			4. Agregue los dos dígitos en la misma columna y también agregue el acarreo en la parte superior de la columna (si corresponde).
			5. Una respuesta de dos dígitos requiere que reste 10 de la suma y registre el resto en la parte inferior de la misma columna.
			6. Una respuesta de dos dígitos también requiere que registre un acarreo de 1 en la siguiente columna a la izquierda y cualquier acarreo adicional se registra en una nueva columna a la izquierda.
			"""
		} else if op == "resta" {
			lbSteps.text =
			"""
			1. Alinea los números de derecha a izquierda. Si un número es más corto, extiéndalo agregando ceros al principio del número.
			2. Trabaje de derecha a izquierda: realice la misma operación de resta y préstamo en cada columna.
			3. Reste los dos dígitos en la misma columna y también reste el préstamo en la parte superior de la columna (si corresponde). Puede obtener una respuesta negativa. Esto está bien, no tome prestado un diez para evitar la respuesta negativa, solo haga la aritmética firmada.
			4. Si la diferencia es positiva o cero, simplemente anótela en la parte inferior de la columna y registre un préstamo 0 en la siguiente columna a la izquierda.
			5. Si la diferencia es negativa, agregue 10 y registre el resultado (que ya no será negativo) en la parte inferior de la columna. También registra un préstamo 1 en la siguiente columna a la izquierda.
			"""
		}
	}
	
	func stepsOperationEnglish(){
		if op == "addition" {
			lbSteps.text =
			"""
			1. Line up the numbers from right to left. If one number is shorter, extend it by adding leading zeros to the front of the shorter number.
			2. Work from right to left - doing the same addition and carry operation in each column.
			3. Add the two digits in the same column and also add the carry at the top of the column (if any).
			4. A one digit answer is simply recorded at the bottom of the same column.
			5. A two digit answer requires you to subtract 10 from the sum and record the remainder at the bottom of the same column.
			6. A two digit answer also requires you to record a carry of 1 in the next column over to the left & any extra carry is recorded in a new column on the left.
			"""
		} else if op == "subtraction" {
			lbSteps.text =
			"""
			1. Line up the numbers from right to left. If one number is shorter extend it by adding leading zeros to the front of the number.
			2. Work from right to left - doing the same subtraction and borrow operation in each column.
			3. Subtract the two digits in the same column and also subtract the borrow at the top of the column (if any). You may get a negative answer. This is OK, do not borrow a ten to avoid the negative answer - just do the signed arithmetic.
			4. If the difference is positive or zero - then just record it at the bottom of the column and record a borrow 0 in the next column left.
			5. If the difference is negative - then add 10 to it and record the result (which will no longer be negative) at the bottom of the column. Also record a borrow 1 in the next column left.
			"""
		}
	}
}
