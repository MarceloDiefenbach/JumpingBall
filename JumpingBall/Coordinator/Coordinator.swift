//
//  Coordinator.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 15/11/22.
//

import Foundation

enum PresentingViews {
    case home, gameRun, winView, difficultySelector, createAccount, login;
}

class Coordinator: ObservableObject {
    
    @Published var isPresentingView: PresentingViews = .home
    
}
