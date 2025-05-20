//
//  Builder.swift
//  P2PCount
//
//  Created by Dany on 29.04.2025.
//

import UIKit

final class Builder{
    
    static func createMainTabBarView() -> UITabBarController {
        let mainTabBar = MainTabBarController()
        let presenter = MainTabBarPresenter(view: mainTabBar)
        mainTabBar.presenter = presenter
        return mainTabBar
    }
    static func createRegistView() -> UIViewController{
        let registVC = RegistrationViewController()
        let presenter = RegistrationViewPresenter(view: registVC)
        registVC.presenter = presenter
        return registVC
    }
    
    static func createAuthorizeView() -> UIViewController{
        let authVC = AuthorizationViewController()
        let presenter = AuthorizationViewPresenter(view: authVC)
        authVC.presenter = presenter
        return authVC
    }
    
    static func createOneCurrencyView() -> UIViewController{
        let oneCurrencyVC = OneCurrencyViewController()
        let presenter = OneCurrencyPresenter(view: oneCurrencyVC)
        oneCurrencyVC.presenter = presenter
        return oneCurrencyVC
    }
    
    static func createMultiCurrencyView() -> UIViewController{
        let multiCurrencyVC = MultiCurrencyViewController()
        let presenter = MultiCurrencyPresenter(view: multiCurrencyVC)
        multiCurrencyVC.presenter = presenter
        return multiCurrencyVC
    }
    
    static func createHistoryView() -> UIViewController {
        let historyView = HistoryViewController()
        let presenter = HistoryViewPresenter(view: historyView)
        historyView.presenter = presenter
        return historyView
    }
}
