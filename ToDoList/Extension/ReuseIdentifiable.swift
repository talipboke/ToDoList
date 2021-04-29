//
//  ReuseIdentifiable.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import UIKit

public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReuseIdentifiable {

    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReuseIdentifiable {

    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

