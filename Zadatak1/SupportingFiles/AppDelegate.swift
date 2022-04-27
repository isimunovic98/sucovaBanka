//
//  AppDelegate.swift
//  Zadatak1
//
//  Created by David Horvat on 20.04.2022..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var mainCoordinator: MainCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        mainCoordinator = MainCoordinator()
        mainCoordinator?.start()
        
        return true
    }
}

