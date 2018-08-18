//
//  RoundedCornerTextField.swift
//  Hitchhkr
//
//  Created by Julian Torres on 8/17/18.
//  Copyright © 2018 Owner. All rights reserved.
//

import UIKit

class RoundedCornerTextField: UITextField {
    
    var textRectOffset : CGFloat = 20


    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: 0 + textRectOffset, y: 0 , width: self.frame.width - textRectOffset, height: self.frame.height)
        
    }
}
