//
//  SignUpViewController.swift
//  lostInVLG
//
//  Created by Ios Dev on 13/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signUpView: UIView!
    var pushedNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Регистрация"
        numberTextField.delegate = self
        passwordTextField.delegate = self
        if let number = pushedNumber {
            numberTextField.text = number
        }
        
        signUpView.layer.shadowColor = UIColor.blue.cgColor
        signUpView.layer.shadowRadius = 5
        signUpView.layer.shadowOpacity = 0.2
        signUpView.layer.shadowOffset = CGSize(width: 3.0, height: 1.0)
        
        registerButton.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 205/255, alpha: 0.5)
        registerButton.layer.borderColor = UIColor.black.cgColor
        registerButton.layer.borderWidth = 1.0
        registerButton.layer.cornerRadius = 10.0
        registerButton.clipsToBounds = true
        registerButton.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        numberTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        let del = UIApplication.shared.delegate as! AppDelegate
        let spinnerView = Utils.displaySpinner(onView: self.view)
        del.authManager.requestRegistration(phone: numberTextField.text!, password: passwordTextField.text!) { (success) in
            if success {
                DispatchQueue.main.async {
                    spinnerView.removeFromSuperview()
                    Utils.showErrorModal(onController: self, withTitle: "Registration success!", andText: "You can log in at previous screen!")
                }
            } else {
                DispatchQueue.main.async {
                    spinnerView.removeFromSuperview()
                    Utils.showErrorModal(onController: self, withTitle: "Registration failed!", andText: "There is an account for this phone number!")
                }
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
