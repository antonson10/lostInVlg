//
//  MainSignUpViewController.swift
//  lostInVLG
//
//  Created by Ios Dev on 03/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import UIKit

class MainSignUpViewController: UIViewController {
    
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Вход"
        numberTextField.delegate = self
        passwordTextField.delegate = self
        
        signInView.layer.shadowColor = UIColor.blue.cgColor
        signInView.layer.shadowRadius = 5
        signInView.layer.shadowOpacity = 0.2
        signInView.layer.shadowOffset = CGSize(width: 3.0, height: 1.0)
        
        loginButton.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 205/255, alpha: 0.5)
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.cornerRadius = 10.0
        loginButton.clipsToBounds = true
        loginButton.layer.masksToBounds = true
        
        registerButton.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 205/255, alpha: 0.5)
        registerButton.layer.borderColor = UIColor.black.cgColor
        registerButton.layer.borderWidth = 1.0
        registerButton.layer.cornerRadius = 10.0
        registerButton.clipsToBounds = true
        registerButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        numberTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        let del = UIApplication.shared.delegate as! AppDelegate
        let spinnerView = Utils.displaySpinner(onView: self.view)
        del.authManager.requestAuthentification(phone: numberTextField.text!, password: passwordTextField.text!) { (newToken) in
            if let token = newToken {
                del.authManager.getUserInfo(token: token, tokenType: "", completion: { (user, error) in
                    if error == nil, let curUser = user {
                        print("\(String(describing: curUser.id)) \(String(describing: curUser.firstName))")
                        DispatchQueue.main.async {
                            spinnerView.removeFromSuperview()
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            spinnerView.removeFromSuperview()
                            Utils.showErrorModal(onController: self, withTitle: "Invalid credentials", andText: "")
                        }
                    }
                })
            } else {
                DispatchQueue.main.async {
                    spinnerView.removeFromSuperview()
                    Utils.showErrorModal(onController: self, withTitle: "Invalid credentials", andText: "")
                }
            }
        }
        
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRegistration" {
            let dc = segue.destination as! SignUpViewController
            dc.pushedNumber = numberTextField.text
        }
    }
}

extension MainSignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

