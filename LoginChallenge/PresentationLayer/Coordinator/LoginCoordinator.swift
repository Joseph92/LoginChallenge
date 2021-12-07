//
//  LoginCoordinator.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 5/12/21.
//

import Foundation
import UIKit

final class LoginCoordinator: NSObject, Coordinator {
    var rootViewController: UINavigationController
    var childs: [Coordinator] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let vc = LoginBuilder().build(coordinator: self)
        rootViewController.pushViewController(vc, animated: false)
    }
    
    func toAttempts() {
        rootViewController.delegate = self
        let coordinator = AttemptsCoordinator(rootViewController: rootViewController)
        childs.append(coordinator)
        coordinator.start()
    }
}

// Verify if the current VC comes from a child VC for removing of the childs array
extension LoginCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
        
        if let attemptsVC = fromVC as? AttemptsViewController {
            childDidFinish(attemptsVC.presenter?.coordinator)
        }
    }
}
