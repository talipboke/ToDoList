//
//  AppConfig.swift
//  GetirTodo
//
//  Created by Talip Böke on 18.04.2021.
//

import Foundation

internal struct AppConfig {
    internal static var isRunningTests: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    internal static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as! String
    }
}
