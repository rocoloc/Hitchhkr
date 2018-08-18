//
//  UiViewExt.swift
//  Hitchhkr
//
//  Created by Julian Torres on 8/4/18.
//  Copyright © 2018 Owner. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(AlphaValue: CGFloat, withDuration duration: TimeInterval){
        UIView.animate(withDuration: duration) {
            self.alpha = AlphaValue
        }
    }
    func bindtoKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
    }
    @objc func keyboardWillChange(_ notification: NSNotification){
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
        
    }

}
