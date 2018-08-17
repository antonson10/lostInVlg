//
//  FindViewController.swift
//  lostInVLG
//
//  Created by Ios Dev on 03/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import UIKit

class FindListViewController: UIViewController {

    @IBOutlet weak var findsTableView: UITableView!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Navigation
extension FindListViewController {
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMainSignIn" {
            //segue.destination.hidesBottomBarWhenPushed = true
        }
    }
}

