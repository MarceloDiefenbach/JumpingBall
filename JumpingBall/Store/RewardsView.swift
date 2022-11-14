//
//  RewardsView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 14/11/22.
//

import SwiftUI

struct RewardsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color("PurplePrimary").ignoresSafeArea()
            ScrollView (showsIndicators: false ) {
                
                VStack(spacing: 16) {
                    Text("Rewards")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 48)
                        .padding(.bottom, 8)
                    
                    Text("You will soon be able to exchange your game coins for cash")
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 40)

                    RewardCell(title: "$1 via PayPal", value: 2000, action: {
                        
                    })
                    RewardCell(title: "$2 via PayPal", value: 4000, action: {
                        
                    })
                    RewardCell(title: "$5 via PayPal", value: 9500, action: {
                        
                    })
                    RewardCell(title: "$10 via PayPal", value: 19000, action: {
                        
                    })
                }.padding(.horizontal, 20)
            }
        }
    }
    
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
    }
}

