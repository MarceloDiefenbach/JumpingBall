//
//  HomeView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 09/11/22.
//

import Foundation
import SwiftUI

struct DifficultySelector: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    @State var isShowingOtherApps: Bool = false
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            VStack (alignment: .leading) {
                HStack {
                    Image("coin")
                        .resizable()
                        .frame(width: 16, height: 16)
                    
                    Text("\(viewModel.coinsCollected)")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.top, 40)
                
                Spacer()
            }.padding(.leading, 20)
            
            VStack {
                
                Text("Select the difficulty\nyou are ready to play")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                HStack {
                    HStack {
                        Text("Easy")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("PurplePrimary"))
                        
                    }
                    .frame(width: UIScreen.main.bounds.width*0.7)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(50)
                }
                .padding(.all, 4)
                .background(Color.clear)
                .cornerRadius(50)
                .onTapGesture {
                    self.viewModel.difficulty = .easy
                    self.coordinator.isPresentingView = .gameRun
                }
                .padding(.bottom, 4)
                
                Text("High score: \(GameDataBase.standard.getHighScore(difficulty: .easy))")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.bottom, 24)
                
                HStack {
                    HStack {
                        Text("Hard")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("PurplePrimary"))
                        
                    }
                    .frame(width: UIScreen.main.bounds.width*0.7)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(50)
                }
                .padding(.all, 4)
                .background(Color.clear)
                .cornerRadius(50)
                .onTapGesture {
                    self.viewModel.difficulty = .hard
                    self.coordinator.isPresentingView = .gameRun
                }
                .padding(.bottom, 4)
                
                Text("High score: \(GameDataBase.standard.getHighScore(difficulty: .hard))")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.bottom, 32)
                
                HStack {
                    Image(systemName: "app.gift")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color.white)
                    Text("More games")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.white)
                    
                }
                .padding(.all, 4)
                .onTapGesture {
                    isShowingOtherApps = true
                }
                
                HStack {
                    HStack {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color("PurplePrimary"))
                        Text("Back to home")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color("PurplePrimary"))
                        
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(50)
                }
                .padding(.all, 4)
                .background(Color.clear)
                .cornerRadius(50)
                .onTapGesture {
                    coordinator.isPresentingView = .home
                }
                .padding(.top, 40)
            }
            
            VStack {
                Spacer()
                BannerAd(unitID: viewModel.AdMobBannerHome).frame(height: 100)
                    .padding(.bottom, 30)
            }
        }
        .sheet(isPresented: $isShowingOtherApps, content: {
            OtherApps()
        })
    }
}
