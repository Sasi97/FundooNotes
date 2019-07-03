//
//  RootDashViewController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/7/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class RootDashViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func layoutViewChanged(_ sender: UISegmentedControl) {
        NotificationCenter.default.post(name: NSNotification.Name("CollectionViewLayouts"), object: nil, userInfo: ["segmentIndex": sender.selectedSegmentIndex])
    }
    
    @IBAction func onClickMenu(_ sender: Any) {
        print("req sent")
        NotificationCenter.default.post(name:NSNotification.Name("SideMenu"),object: nil)
    }
    @IBAction func onClickDropDown(_ sender: Any) {
        print("drop down req sent")
        NotificationCenter.default.post(name:NSNotification.Name("DropDownMenu"),object: nil)
    }
    
    @IBAction func didClickNotes(_ sender: Any) {
        guard let noteVC = self.storyboard?.instantiateViewController(withIdentifier: "noteVC") as? EditAndAddNotes else {
            print("failed to navigate")
            return  }
        navigationController?.pushViewController(viewController: noteVC, animated: true, completion: ({
            noteVC.isEditable = false
        }))
    }
    

}








