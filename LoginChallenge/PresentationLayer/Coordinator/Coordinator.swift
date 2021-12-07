//
//  Coordinator.swift
//  LoginChallenge
//
//  Created by Josseph Colonia on 5/12/21.
//

import Foundation
import UIKit

// Coordinator Pattern
protocol Coordinator: AnyObject {
    var rootViewController: UINavigationController { get }
    var childs: [Coordinator] { get set }
    
    func start()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childs.enumerated() {
            if coordinator === child {
                childs.remove(at: index)
                break
            }
        }
    }
}
