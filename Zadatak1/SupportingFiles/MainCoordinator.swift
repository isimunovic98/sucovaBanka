//
//  MainCoordinator.swift
//  Zadatak1
//
//  Created by David Horvat on 20.04.2022..
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController = UINavigationController()
    let window: UIWindow
    
    init() { self.window = UIWindow(frame: UIScreen.main.bounds) }
    
    func start() {
        window.rootViewController = presenter
        window.makeKeyAndVisible()
        presentHomeScreen()
    }
    
    func presentHomeScreen() {
        let child = HomeCoordinator(presenter: presenter)
        childCoordinators.append(child)
        child.start()
    }
}
