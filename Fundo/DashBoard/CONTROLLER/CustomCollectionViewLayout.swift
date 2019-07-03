//
//  CustomCollectionViewLayout.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/19/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

enum CollectionDisplay {
    case listView
    case gridView
}
class CustomCollectionFlowViewLayout: UICollectionViewFlowLayout {
    
    var display : CollectionDisplay = .gridView {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    convenience override init() {
        self.init()
        self.display = display
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.configureLayout()
    }
    func configureLayout() {
        switch display {
        case .gridView:
            
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                self.itemSize = CGSize(width: optimisedWidth , height: optimisedWidth) // keep as square
            }
            
        case .listView:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width , height: 80)
            }
        }
    }
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configureLayout()
    }
}
