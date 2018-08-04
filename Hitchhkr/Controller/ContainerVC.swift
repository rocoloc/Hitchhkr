//
//  ContaineVC.swift
//  Hitchhkr
//
//  Created by Julian Torres on 8/3/18.
//  Copyright © 2018 Julian Torres. All rights reserved.
//

import UIKit
import QuartzCore // We import QuartzCore, because it is a really handy library that Apple provides and makes UI animations quite simple to deal with.

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

enum showWhichVC {
    case homeVC
}

var showVC: showWhichVC = .homeVC // This is so everytime we launch the app, this will be the first controller to be presented to the user. This will also allow us to monitor and keep track of which VC is currently being addressed on the code.

class ContainerVC: UIViewController {

    var homeVC: HomeVC!
    var leftVC: LeftSidePanelVC!
    var centerController: UIViewController!
    var currentState: SlideOutState = .collapsed {
    didSet {
        let shouldShowShadow = (currentState != .collapsed)
    
        shouldShowShadowForCenterViewController(shouldShowShadow)
        }
    }//This variable helps us to keep track of the left side panel state within this class. Also, whenver the variable has a value set, then we create a constant that will allow us to place a nice shadow when we open the left side panel.
    
    var isHidden: Bool = false //this will allow us to hide the status bar when the left side panel is expanded.
    
    let centerPanelExpandedOffset: CGFloat = 160 //this is how much do we want the current VC to slide towards the right.
    
    var tap = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
        // Do any additional setup after loading the view.
    }

    
    // So, we need a function to help us initialize our respective View Controllers on the center of the screen.
    func initCenter(screen: showWhichVC) {
        
        var presentingController : UIViewController
        
        showVC = screen
        
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        //here we are making sure that if we dont have yet created homeVC, we will make it so if it happens to be NIL then we will create it before refering to it so when we call it we will be sure that it will never ever be NIL.
        
        presentingController = homeVC
        
        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        centerController = presentingController
        
        //And here we are basically making sure of removing everything that we have, before parsin in back HomeVC, this way we always have the least amount of view controllers loaded at once, hence using efficiently our device resources.
        
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
        
        //here we are just parsin in the new view and displaying to the user.
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    } //This will allow us to bounce the status bar up or down
    
    override var prefersStatusBarHidden: Bool{
        return isHidden
    } // this way whenever we execute animateStatusBar will automatically keep track if we want or not to show the status bar.


}

extension ContainerVC: CenterVCDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded) // this will be a boolean value.
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        } // This will only execute when notAlreadyExpanded is true, or actually is just has a value.
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftVC!)
        }
        // If we dont have leftVC loaded, we will load and add it to the StoryBoard on the fly.
    }
    func addChildSidePanelViewController(_ sidePanelController: LeftSidePanelVC){
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            
            setupWhiteCoverView()
            currentState = .leftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
        } else {
            isHidden = !isHidden
            animateStatusBar()
            hideWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: 0) { (finished) in
                if finished == true {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            }
        }
        //this one is pretty self explanatory.
    }
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping : 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    
    func setupWhiteCoverView() {
        let whiteCoverView = UIView(frame: CGRect(x:0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2) {
            whiteCoverView.alpha = 0.75
        }
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        self.centerController.view.addGestureRecognizer(tap)
    }
    func hideWhiteCoverView() {
        for subview in self.centerController.view.subviews {
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }, completion: { (finished) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
    func shouldShowShadowForCenterViewController(_ status: Bool){
        if status == true {
            centerController.view.layer.shadowOpacity = 0.6
        } else {
            centerController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
}

// This extension is private because we ONLY want ContainerVC to be able to access this extension, duh

private extension UIStoryboard {
    // This function makes it easy for us to identify and load the "Main" Storyboard, and do stuff with it.
    
    class func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    // this will allow us to create an instance of LeftSidePanelVC and interact with it.
    class func leftViewController() -> LeftSidePanelVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
    }
    
    //Same procedure for HomeVC
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
//This will allow us to have a clean way of accessing this view controllers on the go on a performance efficient way.
}
