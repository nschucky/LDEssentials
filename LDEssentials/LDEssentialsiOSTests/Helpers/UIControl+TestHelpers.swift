//
//  UIControl+TestHelpers.swift
//  LDEssentialsiOSTests
//
//  Created by Antonio Alves on 2/19/21.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
