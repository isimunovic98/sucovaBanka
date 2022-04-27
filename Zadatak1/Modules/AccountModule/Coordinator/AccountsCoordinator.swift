//
//  AccountCoordinator.swift
//  Zadatak1
//
//  Created by David Horvat on 27.04.2022..
//

import Foundation
import UIKit

class AccountsCoordinator: Coordinator, CoordinatorDelegate {
  
    var controller: AccountViewController
    var parent: ParentCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.controller = AccountsCoordinator.createController()
        controller.viewModel.coordinatorDelegate = self
    }
    
    func start() {
        presenter.pushViewController(controller, animated: false)
    }
    
    static func createController() -> AccountViewController {
        let viewModel = AccountsViewModel(repository: AccountsRepositoryImpl())
        let viewController = AccountViewController(viewModel: viewModel)
        return viewController
    }

    func viewControllerDidFinish() {
        parent?.childDidFinish(self)
    }
}
