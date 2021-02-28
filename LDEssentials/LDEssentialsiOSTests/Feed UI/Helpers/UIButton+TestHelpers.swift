//
//  UIButton+TestHelpers.swift
//  LDEssentialsiOSTests
//
//  Created by Antonio Alves on 2/19/21.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
