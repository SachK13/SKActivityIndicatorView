//
//  ViewController.swift
//  SKActivityIndicatorView
//
//  Created by SachK13 on 12/21/2017.
//  Copyright (c) 2017 SachK13. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class ViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var messageTextField: UITextField!
    
    // Custom Properties
    var statusMessage = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SKActivityIndicator.spinnerColor(UIColor.darkGray)
        SKActivityIndicator.statusTextColor(UIColor.black)
        let myFont = UIFont(name: "AvenirNext-DemiBold", size: 18)
        SKActivityIndicator.statusLabelFont(myFont!)
    }
    
    // MARK: - SKActivityIndicator Styles
    @IBAction func showActivityIndicatorStyle1ButtonTapped(_ sender: Any) {
        SKActivityIndicator.spinnerStyle(.defaultSpinner)
        if let message = messageTextField.text {
            statusMessage = message
        }
        SKActivityIndicator.show(statusMessage, userInteractionStatus: true)
    }
    
    @IBAction func showActivityIndicatorStyle2ButtonTapped(_ sender: Any) {
        SKActivityIndicator.spinnerStyle(.spinningCircle)
        if let message = messageTextField.text {
            statusMessage = message
        }
        SKActivityIndicator.show(statusMessage, userInteractionStatus: true)
    }
    
    @IBAction func showActivityIndicatorStyle3ButtonTapped(_ sender: Any) {
        SKActivityIndicator.spinnerStyle(.spinningFadeCircle)
        if let message = messageTextField.text {
            statusMessage = message
        }
        SKActivityIndicator.show(statusMessage, userInteractionStatus: true)
    }
    
    @IBAction func showActivityIndicatorStyle4ButtonTapped(_ sender: Any) {
        SKActivityIndicator.spinnerStyle(.spinningHalfCircles)
        if let message = messageTextField.text {
            statusMessage = message
        }
        SKActivityIndicator.show(statusMessage, userInteractionStatus: true)
    }
    
    @IBAction func hideActivityIndicatorButtonTapped(_ sender: Any) {
        SKActivityIndicator.dismiss()
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
