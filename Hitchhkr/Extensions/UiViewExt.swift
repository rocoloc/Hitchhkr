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
}
