//
//  ViewController.swift
//  Calculator
//
//  Created by Александр Сибирцев on 28.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var display: UILabel!
    
    private var brain = CalculatorLogics()
    private var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            let tmp = String(newValue).removeAfterPointIfZero()
            display.text = tmp.setMaxLength(of: 8)
        }
    }
 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        
    }
    
    //MARK: IBAction(s)
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            
            if digit == "." && (textCurrentlyInDisplay.range(of: ".") != nil) {
                return
            } else {
                let tmp = textCurrentlyInDisplay + digit
                display.text = tmp.setMaxLength(of: 8)
            }
            
        } else {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
}

