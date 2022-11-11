//
//  ContentView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 08/11/22.
//

import Foundation

class GameDataBase {
    private let userDefaults = UserDefaults.standard
    static var standard = GameDataBase()
    
    private let highScoreKeyEasy: String = "scoreEasy"
    private let highScoreKeyHard: String = "scoreHard"
    private let coinsAmountKey: String = "coinsAmount"
    
    private init() {}
    
    func getHighScore(difficulty: Difficulty) -> Int {
        
        var highScore = 0
        
        if difficulty == .easy {
            highScore = userDefaults.integer(forKey: highScoreKeyEasy)
        
        } else {
            highScore = userDefaults.integer(forKey: highScoreKeyHard)
        
        }
        return highScore
    }
    
    func setHighScore(newHighScore: Int, difficulty: Difficulty) {
        
        let currentHighScore = getHighScore(difficulty: difficulty)
       
        if newHighScore > currentHighScore {
            if difficulty == .easy {
                userDefaults.setValue(newHighScore, forKey: highScoreKeyEasy)
            } else {
                userDefaults.setValue(newHighScore, forKey: highScoreKeyHard)
            }
        }
    }
    
    func setCoinsAmount(newValue: Int) {
        userDefaults.setValue(newValue, forKey: coinsAmountKey)
    }
    
    func getCoinsAmount() -> Int {
        return userDefaults.integer(forKey: coinsAmountKey)
    }
}
