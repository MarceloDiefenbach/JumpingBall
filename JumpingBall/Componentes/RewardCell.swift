//
//  RewardCell.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 14/11/22.
//

import SwiftUI


struct RewardCell: View {
    
    var title: String
    var subtitle: String = ""
    var value: Int
    var action: () -> Void
    
    var body: some View {
        
        HStack {
            VStack (alignment: .leading, spacing: 12){
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                
                if subtitle != "" {
                    Text(subtitle)
                        .font(.system(size: 12, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                }
                
                HStack {
                    Text("Redeem")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("PurplePrimary"))
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(50)
                .onTapGesture {
                    action()
                }
            }
            
            Spacer()
            HStack {
                Image("coin")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("\(value)")
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
            }
        }
        .padding(.all, 16)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 1)
        )

    }
}

struct RewardCell_Previews: PreviewProvider {
    static var previews: some View {
        RewardCell(title: "Reward name", subtitle: "Reward description", value: 5000, action: {})
    }
}
