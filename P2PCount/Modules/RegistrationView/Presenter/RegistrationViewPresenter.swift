//
//  RegisatrationViewPresenter.swift
//  P2PCount
//
//  Created by Dany on 29.04.2025.
//

import Foundation


protocol RegistrationViewPresenterProtocol: AnyObject {
    func registNewUser(userData: UserLoginData)
    func haveAcc()
}

final class RegistrationViewPresenter: RegistrationViewPresenterProtocol {


    weak var view: RegistrationViewControllerProtocol?
    let loginLayer = LoginLayer()
    
    init(view: RegistrationViewControllerProtocol?) {
        self.view = view
    }
    
    func registNewUser(userData: UserLoginData) { 
        loginLayer.createNewUser(userInfo: userData) { isResult in
            if isResult{
                NotificationCenter.default.post(name: .routing, object: nil, userInfo: [String.route : WindowsCase.auth])
            }else{
                print("error")
            }
        }
    }
    
    func haveAcc() {
        NotificationCenter.default.post(name: .routing, object: nil, userInfo: ["route": WindowsCase.auth])
    }
}
