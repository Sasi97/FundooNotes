//
//  HomeViewController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class RootDashboardVC: UIViewController {
      var isMenuPresent = false
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var dashView: UIView!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        //menuView.isHidden=true
       // gestures()
        
      /* let dashboardVC = storyboard?.instantiateViewController(withIdentifier: "dashVC") as? DashBoardViewController
        
        present(dashboardVC!, animated: false, completion: nil)
        dashboardVC?.didTappedHamburger = {
            print("Action received")
            self.didTapMenu()
        }*/
     NotificationCenter.default.addObserver(self, selector: #selector(didTapMenu), name: NSNotification.Name("sideMenuView"), object: nil)
    }
    func gestures(){
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left

        dashView.addGestureRecognizer(tapGesture)
        dashView.addGestureRecognizer(swipeRight)
        dashView.addGestureRecognizer(swipeLeft)
    }
    @objc func tap(){
        if isMenuPresent{
            menuView.isHidden = true
        }
    }
    @objc func swipeGesture(sender:UIGestureRecognizer){
        
        if let swipeGesture = sender as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right: menuView.isHidden = false
                break
            case UISwipeGestureRecognizer.Direction.left: menuView.isHidden = true
                break
            default:
                menuView.isHidden = true
            }
        }
        
    }

    @objc func didTapMenu() {
        print("tapped")
        if isMenuPresent {
            isMenuPresent = false
            leadingConstraint.constant = -207
        }else{
            isMenuPresent = true
            leadingConstraint.constant = 0
        }
        
    }
}
