//
//  LoginVC.swift
//  Hitchhkr
//
//  Created by Julian Torres on 8/10/18.
//  Copyright © 2018 Owner. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindtoKeyboard()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func dismissBtnWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   
}
