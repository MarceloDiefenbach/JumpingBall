//
//  ContentView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 08/11/22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        scene.viewModel = self.viewModel
        return scene
    }

    var body: some View {
        ZStack{
            SpriteView(scene: self.scene)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            VStack {
                Spacer()
                BannerAd(unitID: viewModel.AdMobBannerHome).frame(height: 50)
                    .padding(.bottom, 30)
            }
            if viewModel.didStartGame {
                VStack {
                    Text("Level: \(viewModel.level)")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 24, weight: .light))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    Text("\(viewModel.actualScore)")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            }
            VStack (alignment: .leading) {
                HStack {
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
                    
                    Spacer()
                }
                .padding(.top, 40)
                
                Spacer()
            }.padding(.leading, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
