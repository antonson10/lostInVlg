//
//  ProfileViewController.swift
//  lostInVLG
//
//  Created by Ios Dev on 02/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    var blockerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let del = UIApplication.shared.delegate as! AppDelegate
        let authManager = del.authManager
        if authManager.loggedIn, let user = authManager.currentUser {
            updateUI(user: user)
        } else {
            blockProfileScreen(shouldBlock: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI (user: User) {
        //update name
        if user.firstName == nil && user.lastName == nil {
            nameLabel.text = "Unnamed"
        } else {
            var name = ""
            if let fn = user.firstName {
                name += fn
            }
            if let ln = user.lastName {
                name += name == "" ? ln : " " + ln
            }
            nameLabel.text = name
        }
        //update phone
        numberLabel.text = user.phone
    }
    
    func blockProfileScreen(shouldBlock: Bool) {
        if shouldBlock {
            if blockerView == nil {
                //let newView = UIView(frame: self.view.frame)
                let newView = UIView(frame: self.mainView.frame)
                newView.backgroundColor = UIColor.white
                let notLoggedInLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
                notLoggedInLabel.textAlignment = .center
                notLoggedInLabel.text = "Пожалуйста, войдите в систему."
                //self.view.addSubview(newView)
                self.mainView.addSubview(newView)
                //newView.center = self.view.center
                //newView.center = self.mainView.center
                newView.center = CGPoint(x: self.mainView.frame.size.width / 2, y: self.mainView.frame.size.height / 2)
                newView.addSubview(notLoggedInLabel)
                //notLoggedInLabel.center = newView.center
                notLoggedInLabel.center = CGPoint(x: newView.frame.size.width / 2, y: newView.frame.size.height / 2)
                blockerView = newView
            }
        } else {
            if blockerView != nil {
                blockerView?.removeFromSuperview()
                blockerView = nil
            }
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

}
