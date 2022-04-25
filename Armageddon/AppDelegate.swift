//
//  AppDelegate.swift
//  Armageddon
//
//  Created by Mikhail Danilov on 19.04.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainContainerViewController()
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.setNavigationBarHidden(true, animated: false)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
    return true
    }
}

