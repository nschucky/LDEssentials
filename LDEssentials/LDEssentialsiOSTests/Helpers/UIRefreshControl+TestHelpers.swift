//
//  UIRefreshControl+TestHelpers.swift
//  LDEssentialsiOSTests
//
//  Created by Antonio Alves on 2/19/21.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
