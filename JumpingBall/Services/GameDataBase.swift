//
//  ContentView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 08/11/22.
//

import Foundation
import FirebaseAuth

class GameDataBase {
    
    private let userDefaults = UserDefaults.standard
    static var standard = GameDataBase()
    var firebaseService = FirebaseService()
    
    private let highScoreEasyKey: String = "scoreEasy"
    private let highScoreHardKey: String = "scoreHard"
    private let coinsAmountKey: String = "coinsAmount"
    
    private init() {}
    
    func getHighScore(difficulty: Difficulty) -> Int {
        
        var highScore = 0
        
        if difficulty == .easy {
            firebaseService.getScore(difficulty: .easy)
            highScore = userDefaults.integer(forKey: highScoreEasyKey)
        
        } else {
            firebaseService.getScore(difficulty: .hard)
            highScore = userDefaults.integer(forKey: highScoreHardKey)
        
        }
        return highScore
    }
    
    func setHighScore(newHighScore: Int, difficulty: Difficulty) {
        
        let currentHighScore = getHighScore(difficulty: difficulty)

        if newHighScore > currentHighScore {
            if Auth.auth().currentUser?.email != nil {
                firebaseService.saveScore(difficulty: difficulty, score: newHighScore)
            }
            if difficulty == .easy {
                userDefaults.setValue(newHighScore, forKey: highScoreEasyKey)
            } else {
                userDefaults.setValue(newHighScore, forKey: highScoreHardKey)
            }
        }
    }
    
    func setCoinsAmount(newValue: Int) {
        userDefaults.setValue(newValue, forKey: coinsAmountKey)
        firebaseService.saveCoins(coins: newValue)
    }
    
    func getCoinsAmount() -> Int {
        return userDefaults.integer(forKey: coinsAmountKey)
    }
}
