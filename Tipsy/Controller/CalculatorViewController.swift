//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    var billTotal = 0.0
    var splitNumber : Int = 0
    var tip = 0.0
    var tipString = ""
    var totalPerPerson = 0.0
    var totalPerPersonString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitNumber = 2
        tip = 0
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        print("tip changed")
        if sender == zeroPctButton {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            tip = 0
            tipString = String(tip)
        }else if sender == tenPctButton {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            tip = 0.1
            tipString = String(tip * 100)
        }else{
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            tip = 0.2
            tipString = String(tip * 100)
        }
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumber = Int(sender.value)
        splitNumberLabel.text = String(splitNumber)
        billTextField.endEditing(true)
        print("split changed")
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        if bill != "" {
            billTotal = Double(bill)!
            totalPerPerson = (billTotal + (billTotal * Double(tip))) / Double(splitNumber)
            totalPerPersonString = String(format: "%.2f", totalPerPerson)
            print("total per person is \(totalPerPersonString)")
            
            
            
            //self.performSegue(withIdentifier: "toResults", sender: self)
            
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults" {
            let destination = segue.destination as! ResultViewController
            print(billTotal)
            print(tip)
            print(splitNumber)
            print(totalPerPerson)
            destination.result = totalPerPersonString
            destination.settingsLabel.text = "Split between \(splitNumberLabel.text!) people, with \(tipString)% tip."
        }
    }
    
}

