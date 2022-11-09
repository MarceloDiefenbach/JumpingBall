//
//  JumpingBallApp.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 08/11/22.
//

import SwiftUI

@main
struct JumpingBallApp: App {
    
    @StateObject private var viewModel: GameViewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isPresentingView == .home {
                
            } else if viewModel.isPresentingView == .gameRun {
                ContentView()
                    .environmentObject(viewModel)
                
            } else if viewModel.isPresentingView == .winView {
                WinView()
                    .environmentObject(viewModel)
            }
        }
    }
}
