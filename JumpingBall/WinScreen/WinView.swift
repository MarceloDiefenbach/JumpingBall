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
    
    var body: some View {
        ZStack {
            ZStack {
                Image("End")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
            
            ZStack {
                VStack {
                    Text("Your score")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .padding(.top, (hasNotch() ? UIScreen.main.bounds.height*0.05 : UIScreen.main.bounds.height*0.1))
                    Text("\(viewModel.actualScore)")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 24)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    
                    Text("Watch an ad to return where did you stop")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    VStack {
                        HStack {
                            Image(systemName: "film")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.white)
                            Text("Continue with your points")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                        .background(Color("PurplePrimary"))
                        .cornerRadius(50)
                    }
                    .padding(.all, 4)
                    .background(Color("PurpleSecondary"))
                    .cornerRadius(50)
                    .onTapGesture {
                        print("clicou")
                        DispatchQueue.main.async {
                            viewModel.reward.ShowReward(viewModel: viewModel)
                        }
                    }
                    .disabled(!viewModel.reward.rewardLoaded)
                    .padding(.bottom, 24)
                    
                    Text("Or start over from zero")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    HStack {
                        
                        HStack {
                            Text("Change dificulty")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .cornerRadius(50)
                        .onTapGesture {
                            viewModel.isPresentingView = .difficultySelector
                        }
                        
                        HStack {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color("PurplePrimary"))
                                Text("Restart")
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
                            viewModel.restartGame()
                        }
                    }
                    .padding(.bottom, (hasNotch() ? 0 : 20))
                    
                    BannerAd(unitID: viewModel.AdMobBannerWin).frame(height: 50)
                }
                .padding(.bottom, (hasNotch() ? UIScreen.main.bounds.height*0.02 : UIScreen.main.bounds.height*0.05))
            }
        }
    }
    
    func hasNotch() -> Bool {
        let bottom = UIApplication.shared.windows.first{ $0.isKeyWindow }?.safeAreaInsets.bottom ?? 0
        if bottom == 0.0 {
            return true
        } else {
            return false
        }
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView()
    }
}

