//
//  AppDelegate.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        //App Settings
        configureAppSettings()
        
        //Launch Controller
        let viewController = MoviesModuleBuilder().build()
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

// MARK: - App Configurations
extension AppDelegate {
    
    func configureAppSettings() {
        //Navigation Bar Appearence
        setNavigationBarAppearance()
        
        //Log Configuration
        Utility.defaultUtility.configureSwiftLogger()
        
        //ProgressHUD Configuration
        ProgressHUD.configureAppearance()
    }
    
    func setNavigationBarAppearance() {
        let navBarBG = UIImage.init(named: "navBar")?.withRenderingMode(.alwaysOriginal).resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        UINavigationBar.appearance().setBackgroundImage(navBarBG, for: .default)
        
        let navTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: navTintColor, NSAttributedString.Key.font: UIFont.init(name: "Rockout", size: 32.0) ?? UIFont.boldSystemFont(ofSize: 17)]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self, UINavigationBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: navTintColor], for: .normal)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = navTintColor
        UIButton.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = navTintColor
        UIButton.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleColor(navTintColor, for: .normal)
    }
}
