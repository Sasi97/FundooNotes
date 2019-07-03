//
//  SideMenuTableViewCell.swift
//  Fundo
//
//   Created by BridgeLabz Solutions LLP  on 6/7/19.
//  Copyright © 2019 Apple Inc. All rights reserved.

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
