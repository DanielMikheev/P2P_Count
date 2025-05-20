//
//  LoginLayer.swift
//  P2PCount
//
//  Created by Dany on 04.05.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginLayer {
   
    //1 regist
    func createNewUser(userInfo: UserLoginData, completion: @escaping (Bool) -> Void){
        Auth.auth().createUser(withEmail: userInfo.email, password: userInfo.password) { [weak self] result, err in
            guard let self = self else { return }
            guard err == nil else {
                print(err!.localizedDescription)
                completion(false)
                return
            }
            createUserData(userInfo: userInfo, uid: result?.user.uid ?? ""){
                //2 send verify
                result?.user.sendEmailVerification()
                //3 logout
                AuthLayer.shared.logOut()
                completion(true)
            }
        }
    }
    
    func createUserData(userInfo: UserLoginData, uid: String, completion: @escaping ()->Void){
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .setData([
                "name" : userInfo.name ?? "",
                "dateRegist": Date(),
                "email": userInfo.email
            ]) { _ in
                completion()
            }
    }
    
    func authInApp(userInfo: UserLoginData, completion: @escaping (Result<Bool, Error>)->Void){
        Auth.auth().signIn(withEmail: userInfo.email, password: userInfo.password) { result, err in
            guard err == nil else {
                print(err!.localizedDescription)
                completion(.failure(err!))
                return
            }
            
            guard let user = result?.user else {
                completion(.failure(err!))
                return
            }
            
            if user.isEmailVerified{
                completion(.success(true))
            }else{
                completion(.failure(err!))
            }
        }
    }
}
