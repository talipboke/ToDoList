//
//  UIViewController+Extensions.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import UIKit

public extension UIViewController {
    func add(_ child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }
}
