//
//  AuthLayer.swift
//  P2PCount
//
//  Created by Dany on 04.05.2025.
//

import Foundation
import FirebaseAuth

class AuthLayer {
    static let shared = AuthLayer()
    
    private init () {}
    
    func checkAuth() -> Bool {
        if let _ = Auth.auth().currentUser{
            return true
        }else {
            return false
        }
    }
    
    func logOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            print(error.localizedDescription)
        }
    }
}
