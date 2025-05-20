//
//  AuthorizationViewPresenter.swift
//  P2PCount
//
//  Created by Dany on 03.05.2025.
//

import UIKit

protocol AuthorizationViewPresenterProtocol: AnyObject {
    func authUser(userInfo: UserLoginData)
    func donthaveAcc()
}

class AuthorizationViewPresenter: AuthorizationViewPresenterProtocol {


    private let loginLayer = LoginLayer()
    weak var view: AuthorizationViewControllerProtocol?
    
    init(view: AuthorizationViewControllerProtocol?) {
        self.view = view
    }
    
    func authUser(userInfo: UserLoginData) {
        loginLayer.authInApp(userInfo: userInfo) { result in
            switch result{
            case .success(_):
                NotificationCenter.default.post(name: .routing, object: nil, userInfo: [String.route: WindowsCase.oneCurrency])
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func donthaveAcc(){
        NotificationCenter.default.post(name: .routing, object: nil, userInfo: ["route": WindowsCase.regist])
    }
    
    
}
