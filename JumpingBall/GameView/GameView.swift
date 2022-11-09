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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
