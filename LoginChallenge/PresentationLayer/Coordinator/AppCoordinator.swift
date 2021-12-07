//
//  AppCoordinator.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 5/12/21.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var childs: [Coordinator] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let coordinator = LoginCoordinator(rootViewController: rootViewController)
        coordinator.start()
        childs.append(coordinator)
    }
}
