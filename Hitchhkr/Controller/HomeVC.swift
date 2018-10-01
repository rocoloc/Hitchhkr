//
//  HomeVC.swift
//  Hitchhkr
//
//  Created by Julian Torres on 7/25/18.
//  Copyright © 2018 Julian Torres. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var actionBtn: RoundedShadowButtom!
    
    var delegate : CenterVCDelegate?
    
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = .twitter
        revealingSplashView.startAnimation()
        
        revealingSplashView.heartAttack = true
    }

    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButtom(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func menuButtomWasPressed(_ sender: UIButton) {
        delegate?.toggleLeftPanel()
    }
    
}
