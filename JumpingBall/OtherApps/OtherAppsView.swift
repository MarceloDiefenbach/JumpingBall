//
//  OtherAppsView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 08/11/22.
//

import SwiftUI

struct OtherApps: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color("PurplePrimary").ignoresSafeArea()
            ScrollView (showsIndicators: false ) {
                VStack (alignment: .center) {
                    
                    Text("Other games that\nyou will like")
                        .font(.system(size: 24, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.bottom, 24)
                        .padding(.top, 48)
                    
                    Link(destination: URL(string: "https://apps.apple.com/us/app/tap-to-win-100-free/id6444243503")!) {
                        VStack {
                            Text("Tap To Win")
                                .foregroundColor(.black)
                                .font(.system(size: 24, weight: .bold))
                                .padding(.bottom, 4)
                            
                            Text("Challenge your friends\nto know who tap fastest")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .regular))
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    
                    Link(destination: URL(string: "https://apps.apple.com/us/app/truddy/id1634475601")!) {
                        VStack {
                            Text("Truddy")
                                .foregroundColor(.black)
                                .font(.system(size: 24, weight: .bold))
                                .padding(.bottom, 4)
                            
                            Text("Social game to play\nwith your friends")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .regular))
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    
                    Link(destination: URL(string: "https://apps.apple.com/us/app/flappychicken/id1584123827")!) {
                        VStack {
                            Text("Flappy Chicken")
                                .foregroundColor(.black)
                                .font(.system(size: 24, weight: .bold))
                                .padding(.bottom, 4)
                            
                            Text("Fly with the chicken\nand dodge obstacles")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .regular))
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    
                    Link(destination: URL(string: "https://apps.apple.com/br/app/fiero/id1635658054?l=en")!) {
                        VStack {
                            Text("Fiero")
                                .foregroundColor(.black)
                                .font(.system(size: 24, weight: .bold))
                                .padding(.bottom, 4)
                            
                            Text("Challenge your friends\nto know who is the best")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .regular))
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding(.bottom, 16)
                    }
                    
                    HStack {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color("PurplePrimary"))
                        Text("Back to game")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color("PurplePrimary"))
                        
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(50)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
}

struct OtherApps_Previews: PreviewProvider {
    static var previews: some View {
        OtherApps()
    }
}
