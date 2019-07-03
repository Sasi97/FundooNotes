//
//  GetAlerts.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/17/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
class AlertService {
    static func displayAlert(userMsg:String){
        let alert = UIAlertController(title: "***", message: userMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        
    }
    
}
