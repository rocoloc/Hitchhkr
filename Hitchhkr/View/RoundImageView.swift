//
//  RoundImageView.swift
//  Hitchhkr
//
//  Created by Owner on 7/26/18.
//  Copyright © 2018 Owner. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
