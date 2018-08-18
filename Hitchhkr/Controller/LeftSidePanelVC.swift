//
//  LeftSidePanelVC.swift
//  Hitchhkr
//
//  Created by Owner on 8/3/18.
//  Copyright © 2018 Owner. All rights reserved.
//

import UIKit

class LeftSidePanelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUpBtnWasPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        if loginVC == nil {
            print("LoginVC is nil, you idiot")
        } else {present(loginVC!, animated: true, completion: nil) }
    }
    
}
