//
//  AppDelegate.swift
//  Omise
//
//  Created by Amal Mishra on 22/04/20.
//  Copyright © 2020 Amal Mishra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setAppearance()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension AppDelegate{
    
    ///Setup any customizations required for the project
    func setAppearance(){
        ///Changing the appearance of navigation bar
        UINavigationBar.appearance().tintColor = .black
    }
}

