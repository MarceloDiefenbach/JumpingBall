//
//  HomeView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 14/11/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Image("backgroundWithCharacter")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    HStack {
                        Image(systemName: "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                        Text("Play")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 8)
                    .background(Color("PurplePrimary"))
                    .cornerRadius(50)
                }
                .padding(.all, 4)
                .background(Color("PurpleSecondary"))
                .cornerRadius(50)
                .onTapGesture {
                    viewModel.isPresentingView = .difficultySelector
                }
                .padding(.bottom, 16)
                
                HStack {
                    HStack {
                        Image(systemName: "bag.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color("PurplePrimary"))
                        Text("Rewards")
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
//                    viewModel.isPresentingView = .rewards
                }
                .padding(.bottom, UIScreen.main.bounds.height*0.15)
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
    
}
