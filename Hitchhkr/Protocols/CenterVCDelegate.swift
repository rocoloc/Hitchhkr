//
//  CenterVCDelegate.swift
//  Hitchhkr
//
//  Created by Owner on 8/3/18.
//  Copyright © 2018 Owner. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel() // This will allow us to toggle the panel left and right.
    func addLeftPanelViewController() //This one will allow us to add the panel behind our current VC.
    func animateLeftPanel(shouldExpand : Bool) // And this one will also allow us to handsomely animate the whole thing. If we parse in true it will expand, if not if will close.
}
