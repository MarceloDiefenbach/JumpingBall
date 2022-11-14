//
//  JumpingBallApp.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 08/11/22.
//

import SwiftUI
import FirebaseCore

@main
struct JumpingBallApp: App {
    
    @StateObject private var viewModel: GameViewModel = GameViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isPresentingView == .difficultySelector {
                DifficultySelector()
                    .environmentObject(viewModel)
                
            } else if viewModel.isPresentingView == .gameRun {
                GameView()
                    .environmentObject(viewModel)
                
            } else if viewModel.isPresentingView == .winView {
                WinView()
                    .environmentObject(viewModel)
                
            } else if viewModel.isPresentingView == .home {
                HomeView()
                    .environmentObject(viewModel)
            }
        }
    }
}
