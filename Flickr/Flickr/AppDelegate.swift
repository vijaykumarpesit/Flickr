//
//  AppDelegate.swift
//  Flickr
//
//  Created by Vijaykumar Bhat on 10/09/18.
//  Copyright © 2018 Vijaykumar Bhat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame:UIScreen.main.bounds)
        self.window?.rootViewController = self.initialiseRootVC()
        self.window?.makeKeyAndVisible()
        return true
    }
    
    //For complex app move this code to UIManager and make use of flow codinators to coordinate between multiple screens
    func initialiseRootVC() -> UIViewController {
        let displayVC =  FLPhotoDisplayVC.init(nibName:"FLPhotoDisplayVC",bundle:nil)
        displayVC.viewModel = FLPhotoDisplayViewModel.init(dataSource: FLPhotoDataSource())
        return displayVC
    }
}

