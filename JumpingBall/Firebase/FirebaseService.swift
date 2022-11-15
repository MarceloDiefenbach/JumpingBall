//
//  FirebaseService.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 15/11/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct FirebaseService {
    
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    func verifyIfUsernameIsAlreadyInUse(username: String, completionHandler: @escaping (Bool) -> Void) {
        
        var exist: Bool = false
        
        db.collection("users").whereField("username", isEqualTo: username).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                exist = true
            } else {
                for document in querySnapshot!.documents {

                    let usernameData = document.data()["username"] as? String
                    
                    if usernameData?.lowercased() == username.lowercased() {
                        exist = true
                        break
                    } else {
                        exist = false
                    }
                    
                }
            }
            completionHandler(exist)
        }
    }
    
    func getUserByEmail(email: String, completionHandler: @escaping (String) -> Void) {
        
        var ownerUsernameReceiver: String = ""
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if document.data()["email"] as? String == email {
                        ownerUsernameReceiver = document.data()["username"] as! String
                    }
                    
                }
            }
            completionHandler(ownerUsernameReceiver)
        }
    }
    
    func saveScore(difficulty: Difficulty, score: Int) {
        let username = UserDefaults.standard.string(forKey: "username")
        let collectionString: String
        
        if difficulty == .easy {
            collectionString = "rankingEasy"
        } else {
            collectionString = "rankingHard"
        }
        
        db.collection(collectionString).document(username ?? "dont'have").setData([
            "username": username ?? "dont'have",
            "score": score
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        db.collection("users").document(username ?? "dont'have").setData([
            "username": username ?? "dont'have",
            "score": score
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getScore(difficulty: Difficulty) {
        let username = UserDefaults.standard.string(forKey: "username")
        let difficultyReceived: String
        
        if difficulty == .easy {
            difficultyReceived = "scoreEasy"
        } else {
            difficultyReceived = "scoreHard"
        }
        
        db.collection("users").whereField("username", isEqualTo: username ?? "").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                if let snapshotDocumentos = querySnapshot?.documents {
                    for doc in snapshotDocumentos {
                        
                        let data = doc.data()
                        
                        if let username = data["username"] as? String,
                           let score = data[difficultyReceived] as? Int {
                                
                            GameDataBase.standard.setHighScore(newHighScore: score, difficulty: difficulty)
                        } else {
                            
                        }
                    }
                }
            }
        }
    }
    
    func saveCoins(coins: Int) {
        let username = UserDefaults.standard.string(forKey: "username")
        
        db.collection("users").document(username ?? "").setData(
            [
                "coins": coins
            ], merge: true) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with")
                }
        }
    }
    
    func getCoins() {
        let username = UserDefaults.standard.string(forKey: "username")
        
        db.collection("users").whereField("username", isEqualTo: username ?? "").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                if let snapshotDocumentos = querySnapshot?.documents {
                    for doc in snapshotDocumentos {
                        
                        let data = doc.data()
                        
                        if let username = data["username"] as? String,
                           let coins = data["coins"] as? Int {
                                
                            UserDefaults.standard.setValue(coins, forKey: "coinsAmount")
                        } else {
                            
                        }
                    }
                }
            }
        }
    }
    
}
