//
//  HomeView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 14/11/22.
//

import SwiftUI
import FirebaseAnalytics

struct HomeView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    @State var isShowingRewardsView: Bool = false
    @State var isShowingProfileView: Bool = false
    
    var body: some View {
        ZStack {
            Image("backgroundWithCharacter")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            VStack {
                HStack {
                    if userViewModel.isLogged() {
                        Spacer()
                    }
                    
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
                    
                    if userViewModel.isLogged() {
                        Spacer()
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.top, 40)
                            .padding(.trailing, 20)
                            .onTapGesture {
                                isShowingProfileView = true
                            }
                    }
                }
                
                Spacer()
            }.padding(.leading, 20)
            
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
                    Analytics.logEvent("play", parameters: ["app": ""])
                    coordinator.isPresentingView = .difficultySelector
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
                    Analytics.logEvent("rewards", parameters: ["app": ""])
                    isShowingRewardsView = true
                }
                .padding(.bottom, 24)
                
                if !userViewModel.isLogged() {
                    Text("Do login to save your points")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .onTapGesture {
                            Analytics.logEvent("createAccount", parameters: ["app": ""])
                            coordinator.isPresentingView = .createAccount
                        }
                }
                HStack{}.padding(.bottom, UIScreen.main.bounds.height*0.15)
            }
            
            VStack {
                Spacer()
                BannerAd(unitID: viewModel.AdMobBannerHome).frame(height: 50)
                    .padding(.bottom, 30)
            }
        }.sheet(isPresented: $isShowingRewardsView, content: {
            RewardsView()
        })
        .sheet(isPresented: $isShowingProfileView, content: {
            ProfileView()
        })
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
    
}
