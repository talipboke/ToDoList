//
//  UITableView+Extensions.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import UIKit
import Foundation

extension UITableView {
    /**
     Returns a cell previously registered in the tableView and mapped to its concrete type.
     */
    func dequeueReusableCell<T: UITableViewCell>(withClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("Cell must be registered")
        }
        return cell
    }

    /**
     Returns a view previously registered in the tableView and mapped to its concrete type.
     */
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass: T.Type) -> T {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            preconditionFailure("Cell must be registered")
        }
        return view
    }
}
