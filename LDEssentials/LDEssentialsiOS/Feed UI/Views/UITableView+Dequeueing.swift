//
//  UITableView+Dequeueing.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/23/21.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
