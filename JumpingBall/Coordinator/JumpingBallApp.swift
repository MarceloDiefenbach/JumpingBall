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
    
    @StateObject private var gameViewModel: GameViewModel = GameViewModel()
    @StateObject private var userViewModel: UserViewModel = UserViewModel()
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            
            if coordinator.isPresentingView == .difficultySelector {
                DifficultySelector()
                    .environmentObject(gameViewModel)
                    .environmentObject(coordinator)
                
            } else if coordinator.isPresentingView == .gameRun {
                GameView()
                    .environmentObject(gameViewModel)
                    .environmentObject(coordinator)
                
            } else if coordinator.isPresentingView == .winView {
                WinView()
                    .environmentObject(gameViewModel)
                    .environmentObject(coordinator)
                
            } else if coordinator.isPresentingView == .home {
                HomeView()
                    .environmentObject(gameViewModel)
                    .environmentObject(userViewModel)
                    .environmentObject(coordinator)
                
            } else if coordinator.isPresentingView == .createAccount {
                CreateAccountView()
                    .environmentObject(userViewModel)
                    .environmentObject(coordinator)
                
            } else if coordinator.isPresentingView == .login {
                LoginView()
                    .environmentObject(userViewModel)
                    .environmentObject(coordinator)
            }
        }
    }
}
