//
//  AttemptsCoordinator.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 7/12/21.
//

import Foundation
import UIKit

final class AttemptsCoordinator: NSObject, Coordinator {
    var rootViewController: UINavigationController
    var childs: [Coordinator] = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let vc = AttemptsBuilder().build(coordinator: self)
        vc.modalPresentationStyle = .fullScreen
        rootViewController.pushViewController(vc, animated: true)
    }
}

// Verify if the current VC comes from a child VC for removing of the childs array
extension AttemptsCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
    }
}
