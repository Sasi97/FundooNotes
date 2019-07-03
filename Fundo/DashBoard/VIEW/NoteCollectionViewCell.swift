//
//  NoteCollectionViewCell.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/19/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var remainderLbl: UILabel!
    var cellColor:UIColor!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
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
//        remainderLbl.text = dateFormatter.string(from: note.remainder) as String
       cellColor = UIColor.init(hex: note.color!)
        backgroundColor = cellColor
    }

   
}
