//
//  UserViewModel.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 15/11/22.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class UserViewModel: ObservableObject {
    
    var firebaseService = FirebaseService()
    let firebaseAuth = Auth.auth()
    let db = Firestore.firestore()
    
    func createAccount(username: String, email: String, password: String, completionHandler: @escaping (AlertCases) -> Void) {
        
        if email == "" || password == "" || username == "" {
            completionHandler(.emptyFields)
            
        } else if !email.contains("@") || !email.contains(".") {
            completionHandler(.invalidEmail)
            
        } else {
            
            firebaseService.verifyIfUsernameIsAlreadyInUse(username: username, completionHandler: { (existUsername) -> Void in
                
                if existUsername {
                    completionHandler(.usernameAlreadyExist)
                
                } else {
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        
                        if error == nil {
                            self.db.collection("users").document(username).setData(
                                [
                                    "username": username,
                                    "email": email,
                                    "coins": 0,
                                    "scoreEasy": 0,
                                    "scoreHard": 0
                                ]
                                , merge: true
                            )
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.saveOnUserDefaults(email: email)
                                completionHandler(.success)
                            })
                        } else {
                            print(error!._code)
                            switch error!._code {
                                case 17007:
                                    completionHandler(.emailAlreadyExist)
                                case 17026:
                                    completionHandler(.weakPassword)
                                default:
                                    completionHandler(.defaultError)
                            }
                        }
                    }
                }
            })
        }
    }
    
    func doLogin(email: String, password: String, completionHandler: @escaping (AlertCases) -> Void) {
        
        if email == "" || password == "" {
            completionHandler(.emptyFields)
            
        } else if !email.contains("@") || !email.contains("."){
            completionHandler(.invalidEmail)
            
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
                if authResult != nil {
                    saveOnUserDefaults(email: email)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        firebaseService.getScore(difficulty: .easy)
                        firebaseService.getCoins()
                        completionHandler(.success)
                    })
                } else {
                    print(error!._code)
                    switch error!._code {
                        case 17007:
                            completionHandler(.emailAlreadyExist)
                        case 17009:
                            completionHandler(.emailAlreadyExist)
                        default:
                            completionHandler(.defaultError)
                    }
                }
            }
        }
    }
    
    func logOut(coordinator: Coordinator) {
        do {
            try firebaseAuth.signOut()
            coordinator.isPresentingView = .home
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func deleteUser(coordinator: Coordinator) {
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        self.firebaseAuth.currentUser?.delete()
        self.db.collection("users").document(username ?? "").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                do {
                    try self.firebaseAuth.signOut()
                    coordinator.isPresentingView = .home
                    
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }
        }
        
    }
    
    func saveOnUserDefaults(email: String) {
        
        firebaseService.getUserByEmail(email: email, completionHandler: { (response) in
            UserDefaults.standard.set(response, forKey: "username")
            UserDefaults.standard.set(email, forKey: "email")
        })
        
    }
    
    func isLogged() -> Bool {
        
        if firebaseAuth.currentUser?.email != nil {
            return true
        } else {
            return false
        }
    }
}
