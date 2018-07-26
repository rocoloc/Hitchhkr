//
//  ViewController.swift
//  Hitchhkr
//
//  Created by Owner on 7/25/18.
//  Copyright © 2018 Owner. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     mapView.delegate = self
    }

   

}

