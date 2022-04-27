//
//  ParentCoordinatorDelegate.swift
//  Zadatak1
//
//  Created by David Horvat on 27.04.2022..
//

import Foundation

protocol ParentCoordinatorDelegate: Coordinator { }

extension ParentCoordinatorDelegate where Self: Coordinator {
     func childDidFinish(_ coordinator: Coordinator) {
        for (index, coord) in childCoordinators.enumerated() {
            if coord === coordinator {
                childCoordinators.remove(at: index)
            }
        }
    }
}

