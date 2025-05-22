//
//  MainTabBarPresenter.swift
//  P2PCount
//
//  Created by Dany on 08.05.2025.
//

import UIKit

protocol MainTabBarPresenterProtocol: AnyObject {
    
}

class MainTabBarPresenter: MainTabBarPresenterProtocol{
    
    weak var view: MainTabBarControllerProtocol?
    
    init(view: MainTabBarControllerProtocol?) {
        self.view = view
        
    }
}
