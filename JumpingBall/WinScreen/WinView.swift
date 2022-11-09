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
                Text("\(GameDataBase.standard.getHighScore())")
                    .font(.system(size: 56, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                HStack {
                    HStack {
                        Image(systemName: "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("PurplePrimary"))
                        Text("Tap to restart")
                            .font(.system(size: 20, weight: .bold))
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
                    self.viewModel.isPresentingView = .gameRun
                }
                .padding(.bottom, 24)
                
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
                BannerAd(unitID: viewModel.AdMobBannerWin).frame(minHeight: 50, idealHeight: 80, maxHeight: 100, alignment: .bottom)
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

