//
//  DropDownMenuTableController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/10/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class DropDownMenuTableController: UITableViewController {
    
    var arrLabels = ["Profile","Settings","SignOut"]
    var arrImages = [#imageLiteral(resourceName: "user"),#imageLiteral(resourceName: "icons8-settings-50"),#imageLiteral(resourceName: "logout")]
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! DropDownMenuTableViewCell
        cell.menuImg.image = arrImages[indexPath.row]
//        cell.menuLbl.text = arrLabels[indexPath.row]
        return cell
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell is\(indexPath.row)")
    }
    

  

 

}
