//
//  HomeView.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import Foundation

import UIKit

internal final class HomeView: UIView {
    
    internal lazy var listView = UIView()
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutViews()
    }
    
    internal required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension HomeView {
    func layoutViews() {
        addSubview(listView)
        listView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            listView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            listView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
