//
//  DashBoardViewController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/6/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class ChildDashboardVC: UIViewController {
    
   //var didTappedHamburger : (() -> ())?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func didClickMenu(_ sender: Any) {
        
      //didTappedHamburger?()
        print("action sent")
      NotificationCenter.default.post(name: NSNotification.Name("sideMenuView"), object: nil)
    }

}
