//
//  AppDelegate.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 04/02/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = Assembly.assemble()
        return true
    }
    
}

