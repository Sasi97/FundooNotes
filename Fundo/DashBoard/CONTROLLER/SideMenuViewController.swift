//
//  SideMenuViewController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/7/19.
//  Copyright © 2019 Apple Inc. All rights reserved.

import UIKit

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
var arrLabels = ["Notes","Pinned","Archive","Bin","Settings","Help"]
var arrImages = [#imageLiteral(resourceName: "notes"),#imageLiteral(resourceName: "icons8-map-pin-32"),#imageLiteral(resourceName: "archive"),#imageLiteral(resourceName: "icons8-trash-50"),#imageLiteral(resourceName: "icons8-settings-50"),#imageLiteral(resourceName: "icons8-support-50")]
extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuTableViewCell
        cell.img.image = arrImages[indexPath.row]
        cell.lblTitle.text = arrLabels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell is\(indexPath.row)")
        switch indexPath.row{
        case nameForIndexpath.notes.rawValue :
        NotificationCenter.default.post(name:NSNotification.Name("SideMenu"),object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("DisplayNotes"), object: nil, userInfo: ["indexPath":indexPath.row])
        case nameForIndexpath.isPinned.rawValue: break
           
        default:
            print("default")
        }
    }
    
    
}
extension SideMenuViewController{
    enum nameForIndexpath: Int {
        case notes = 0
        case isPinned = 1
        case isArchived = 2
        case movedToTrash = 3
    }
}
