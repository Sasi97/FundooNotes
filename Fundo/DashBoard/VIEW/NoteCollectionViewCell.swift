//
//  NoteCollectionViewCell.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/19/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var remainderView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var remainderLbl: UILabel!
    var cellColor:UIColor!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        remainderView.layer.cornerRadius = 50
        remainderView.layer.masksToBounds = true
        remainderView.layer.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
       
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    func bindNoteCard(note : Note) {
        titleLbl.text = note.title
        descriptionLbl.text = note.description
          let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        remainderLbl.text = dateFormat.string(from: note.remainder!)
       cellColor = UIColor.init(hex: note.color!)
        backgroundColor = cellColor
        
    }

   
}
