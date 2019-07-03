//
//  MenuHelper.swift
//  Fundo
//
//  Created by BharatVamsy Bandi on 08/06/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

public class MenuHelper{
    
    public static func getSideMenu() -> SJSwiftSideMenuController {
        let storyBoard = UIStoryboard(name: "DashBoard", bundle: nil)
        let mainVC = SJSwiftSideMenuController()
        if let sideVC_L = (storyBoard.instantiateViewController(withIdentifier: "SideMenuController") as? SideMenuViewController) {
            if let rootVC = storyBoard.instantiateViewController(withIdentifier: "dashBoardVC") as? RootDashViewController {
                SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: nil, leftMenuType: .SlideOver, rightMenuType: .SlideView)
            }
        }
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        SJSwiftSideMenuController.enableDimbackground = true
        SJSwiftSideMenuController.leftMenuWidth = 280
        return mainVC
    }
    public static func setNavigationToLogin(viewController: UIViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let navVC = UINavigationController.init(rootViewController: viewController)
        navVC.isNavigationBarHidden = true
        if (appDelegate.window?.rootViewController?.presentedViewController) != nil
        {
            appDelegate.window?.rootViewController = navVC
        }
        else if (appDelegate.window?.rootViewController?.children) != nil
        {
            appDelegate.window?.rootViewController = navVC
        }
    }
    
    public static func hideSideMenu() {
        SJSwiftSideMenuController.hideLeftMenu()
    }
    
}
