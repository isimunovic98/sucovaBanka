//
//  Coordinator.swift
//  Zadatak1
//
//  Created by David Horvat on 20.04.2022..
//

import Foundation
import UIKit

//enum Event {
//    case registerTapped
//    case logOutTapped
//}

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
//    func eventOccurred(with type: Event)
    func start()
    
}

//protocol Coordinating {
//    var coordinator: Coordinator? { get set }
//}
