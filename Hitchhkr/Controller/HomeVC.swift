//
//  HomeVC.swift
//  Hitchhkr
//
//  Created by Julian Torres on 7/25/18.
//  Copyright © 2018 Julian Torres. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var actionBtn: RoundedShadowButtom!
    
    var delegate : CenterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButtom(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuButtomWasPressed(_ sender: UIButton) {
        delegate?.toggleLeftPanel()
    }
    
}

