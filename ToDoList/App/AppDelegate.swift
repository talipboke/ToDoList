//
//  AppDelegate.swift
//  GetirTodo
//
//  Created by Umut Afacan on 21.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?
    internal var dependencies: AppDependencies?
    internal var appCoordinator: CoordinatorProtocol?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        if !AppConfig.isRunningTests {
            
            let navigationController = UINavigationController()
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            
            let dependencies = AppDependencies()
            self.dependencies = dependencies
            
            appCoordinator = dependencies.makeAppCoordinator(navigationController)
            appCoordinator?.start()
        }
        
        return true
    }
}
