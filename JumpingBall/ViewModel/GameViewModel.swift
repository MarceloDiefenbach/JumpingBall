//
//  GameViewModel.swift
//  TapToWin
//
//  Created by Marcelo Diefenbach on 05/11/22.
//

import Foundation

enum PresentingViews {
    case home, gameRun, winView, difficultySelector;
}

enum Difficulty {
    case easy, medium, hard;
}

class GameViewModel: ObservableObject {
    
    @Published var AdMobBannerHome: String = "ca-app-pub-7490663355066325/4061015077"
    @Published var AdMobBannerWin: String = "ca-app-pub-7490663355066325/2744063979"
    @Published var AdMobBannerGame: String = "ca-app-pub-7490663355066325/8938501885"
    //    @Published var AdMobBannerHome: String = "ca-app-pub-3940256099942544/2934735716"
    //    @Published var AdMobBannerWin: String = "ca-app-pub-3940256099942544/2934735716"
//    @Published var AdMobBannerGame: String = "ca-app-pub-3940256099942544/2934735716"
    
    @Published var isPresentingGameView: Bool = false
    @Published var isPresentingView: PresentingViews = .home
    
    @Published var isGameOver: Bool = false
    @Published var didStartGame: Bool = false
    
    @Published var actualScore: Int = 0
    @Published var coinsCollected: Int = GameDataBase.standard.getCoinsAmount()
    @Published var difficulty: Difficulty = .hard
    
    @Published var level: Int = 1
    
    func restartGame() {
        isPresentingView = .gameRun
        actualScore = 0
    }
    
    func goToHome() {
        isPresentingView = .home
        actualScore = 0
    }
    
}
