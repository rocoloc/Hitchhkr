//
//  RoundedShadowButtom.swift
//  Hitchhkr
//
//  Created by Owner on 7/26/18.
//  Copyright © 2018 Owner. All rights reserved.
//

import UIKit

class RoundedShadowButtom: UIButton {

    var originalSize: CGRect?
    // this will allow us to save the original buttom shape and location on screen
    
    func setupView() {
        
        originalSize = self.frame
        //  here we saved it, yai!
        self.layer.cornerRadius = 5.0 // This will make all the corners rounded
        self.layer.shadowRadius = 10.0 // this will also make all the shadows round
        self.layer.shadowColor = UIColor.darkGray.cgColor // we also want dark gray shadows, duh
        self.layer.shadowOpacity = 0.3 //and we want light shadows not full and absolute darkness
        self.layer.shadowOffset = CGSize.zero // and we do not want those shadows leaning nor to left or right so we stick em to zero, which means center.
    }
    
    override func awakeFromNib() {
        setupView()
    } //this will modify the UI before the view loads so when it loads all those changes will appear.

    
    func animateButtom(shouldLoad: Bool, withMessage message: String?){
        
        let spinner = UIActivityIndicatorView() // we create a spinner, yai
        spinner.activityIndicatorViewStyle = .whiteLarge //yes, we want a white AND large spinner for our users to look at.
        spinner.color = UIColor.darkGray //fancy colour magic code.
        spinner.alpha = 0.0 // but we want it to be transparent, so its there, just so the users cant see it (yet) MUAHAHA
        spinner.hidesWhenStopped = true //this is handy and self explanatory
        spinner.tag = 21 //this is a little something that will help us in the future
        
        if shouldLoad {
            
            self.addSubview(spinner) // first we add the spinner, which at this point is invisible.
            self.setTitle("", for: .normal) //we set the button tittle to blanc, cuz is in mid transition.
            UIView.animate(withDuration: 0.2, animations: { //we want the UI to animate, in the middle of the screen minus half the frame size of the buttom, so it is centered. with the same height and width as the height as the original buttom frame, so it becomes a circle.
            self.layer.cornerRadius = self.frame.height / 2
            self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }, completion: { (finished) in
                if finished == true {
                   
                    spinner.startAnimating() //we also want out invisible spinner to start moving.
                    spinner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1) //we want it to be placed in the exact middle of the screen.
                    UIView.animate(withDuration: 0.3, animations: {
                        spinner.alpha = 1.0 //and we want the spinner now that is animating to be opaque, AKA presented to the user.
                        })
                    }
                })
                    self.isUserInteractionEnabled = false //and we also disable the buttom so the user cannot trigger its functionality again.
                } else {
                    self.isUserInteractionEnabled = true
                    
                    for subview in self.subviews {
                    if subview.tag == 21 {
                        subview.removeFromSuperview()
                    }
                }
                    UIView.animate(withDuration: 0.2, animations: {
                        self.layer.cornerRadius = 5.0
                        self.frame = self.originalSize!
                        self.setTitle(message, for: .normal)
            })
        }
    }
}

