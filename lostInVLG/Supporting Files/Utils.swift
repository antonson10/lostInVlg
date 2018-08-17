//
//  Utils.swift
//  lostInVLG
//
//  Created by Ios Dev on 06/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func showErrorModal(onController ctrl: UIViewController, withTitle title: String?, andText text: String?) {
        let modal = UIAlertController(title: title ?? nil, message: text ?? nil, preferredStyle: .alert)
        modal.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        ctrl.present(modal, animated: true, completion: nil)
    }
    
    static func displaySpinner(onView view: UIView) -> UIView {
        let spinnerView = UIView(frame: view.frame)
        spinnerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        spinnerView.center = view.center
        let AI = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinnerView.addSubview(AI)
        AI.center = spinnerView.center
        AI.startAnimating()
        AI.hidesWhenStopped = true
        view.addSubview(spinnerView)
        
        return spinnerView
    }
}
