//
//  SceneDelegate.swift
//  P2PCount
//
//  Created by Dany on 29.04.2025.
//

import UIKit
import CoreData


enum WindowsCase{
    case regist
    case auth
    case oneCurrency
}

enum AddCircles{
    case one
    case multi
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let rootView = /*AuthLayer.shared.checkAuth() ? Builder.createMainTabBarView() : */Builder.createRegistView()
        self.window?.rootViewController = rootView
        self.window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(windowsManager(notificaion: )), name: .routing , object: nil)
    }


    
    
    @objc func windowsManager(notificaion: Notification ){
        guard let userInfo = notificaion.userInfo else { return }
        if let window = userInfo[String.route] as? WindowsCase {
            switch window{
            case .regist:
                let registVC = Builder.createRegistView() as? RegistrationViewController
                self.window?.rootViewController = registVC
            case .auth:
                let authVC = Builder.createAuthorizeView() as? AuthorizationViewController
                self.window?.rootViewController = authVC
            case .oneCurrency:
                let main = Builder.createMainTabBarView() as? MainTabBarController
                self.window?.rootViewController = main
            }
        }
    }
}

