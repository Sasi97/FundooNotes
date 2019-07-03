//
//  DropDownMenuTableViewCell.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/10/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class DropDownMenuTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var menuLbl: UILabel!
    @IBOutlet weak var menuImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
