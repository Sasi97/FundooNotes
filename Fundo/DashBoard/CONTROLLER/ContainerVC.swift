//
//  ContainerVC.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/10/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    

    @IBOutlet weak var dropMenuConst: NSLayoutConstraint!
    @IBOutlet weak var dropDownMenu: UIView!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var dashView: UIView!
    var isMenuOpen = false
    var isDropDownOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSideMenu), name: NSNotification.Name("SideMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setUpDropdownMenu), name: NSNotification.Name("DropDownMenu"), object: nil)
        
    dropDownMenu.isHidden = true
       // gestures()
    }
    func gestures(){
        dashView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        let swipeTop = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeTop.direction = UISwipeGestureRecognizer.Direction.up
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        
        dashView.addGestureRecognizer(tapGesture)
        dashView.addGestureRecognizer(swipeRight)
        dashView.addGestureRecognizer(swipeLeft)
        dashView.addGestureRecognizer(swipeTop)
        dashView.addGestureRecognizer(swipeDown)
    }
    @objc func tap(){
        if isMenuOpen && isDropDownOpen{
            sideMenuView.isHidden = true
            dropDownMenu.isHidden = true
        }
    }
    @objc func swipeGesture(sender:UIGestureRecognizer){
        
        if let swipeGesture = sender as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right: sideMenuView.isHidden = false
                break
            case UISwipeGestureRecognizer.Direction.left: sideMenuView.isHidden = true
                break
            default:
                sideMenuView.isHidden = true
            }
        }
        
    }

    @objc func setUpSideMenu()  {
        print("value observed")
        if isMenuOpen{
           // dropDownMenu.isHidden = false
            isMenuOpen = false
            leadingConst.constant = -240
        }else {
           // dropDownMenu.isHidden = true
            isMenuOpen = true
            leadingConst.constant = 0
        }
        UIView.animate(withDuration:0.2){
            self.view.layoutIfNeeded()
        }
        
    }
   @objc func setUpDropdownMenu()  {
        print("DropDownValueObserved")
        dropDownMenu.isHidden = false
        if isDropDownOpen{
            isDropDownOpen = false
            dropMenuConst.constant = -338
        }else{
            isDropDownOpen = true
            dropMenuConst.constant = 44
        }
    UIView.animate(withDuration:0.3){
        self.view.layoutIfNeeded()
    }
    }

    
    


}
