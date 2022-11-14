//
//  WinView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 08/11/22.
//

import Foundation
import SwiftUI

struct WinView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    @State var isShowingOtherApps: Bool = false
    
    @State var collectedDiamonds: Int = 0
    
    @ObservedObject var reward = Reward()

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("YOUR SCORE")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.white)
                Text("\(viewModel.actualScore)")
                    .font(.system(size: 56, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 24)
                Text("HIGH SCORE")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.white)
                Text("\(GameDataBase.standard.getHighScore(difficulty: self.viewModel.difficulty))")
                    .font(.system(size: 56, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                HStack {
                    HStack {
                        Image(systemName: "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color("PurplePrimary"))
                        Text("Restart")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color("PurplePrimary"))
                        
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(50)
                }
                .padding(.all, 4)
                .background(Color.clear)
                .cornerRadius(50)
                .onTapGesture {
                    viewModel.restartGame()
                }
                
                VStack {
                    HStack {
                        Image(systemName: "film")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("PurplePrimary"))
                        Text("Continue with your points")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("PurplePrimary"))
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(50)
                    Text("Watch an ad")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(Color("PurplePrimary"))
                }
                .padding(.all, 4)
                .background(Color.clear)
                .cornerRadius(50)
                .onTapGesture {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                        reward.ShowReward(viewModel: viewModel)
                    })
                }
                .onAppear() {
                    reward.LoadReward()
                }
                .disabled(!reward.rewardLoaded)
                .padding(.bottom, 24)
                
                HStack {
                    Text("Change difficulty")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color.white)
                }
                .padding(.all, 4)
                .onTapGesture {
                    viewModel.goToHome()
                }
                .padding(.bottom, 40)
                
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
                Spacer()
//                BannerAd(unitID: viewModel.AdMobBannerHome).frame(height: 100)
//                    .padding(.bottom, 30)
            }
            .padding(.vertical, 50)
        }.sheet(isPresented: $isShowingOtherApps, content: {
            OtherApps()
        })
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()
    }
}

