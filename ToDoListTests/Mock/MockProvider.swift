//
//  MockProvider.swift
//  GetirTodoTests
//
//  Created by Talip Böke on 20.04.2021.
//

import UIKit
@testable import GetirTodo

internal struct MockProvider {
    internal static func createRouteWindowAndMakeVisible(_ navigationController: UINavigationController) {
        let window = UIWindow(frame: .zero)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    internal static func createMockTodo(title: String = "Başlık 1",
                                        content: String = "İçerik 1") -> TodoDto {
        return TodoDto(title: title,
                       content: content)
    }
}
