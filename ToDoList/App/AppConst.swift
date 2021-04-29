//
//  AppConst.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import Foundation

internal enum AppConst: String {
    case homeNavigationTitle = "To-Do List :)"
    case title = "Title"
    case content = "Content"
    
    func localize() -> String {
        return self.rawValue
    }
}
