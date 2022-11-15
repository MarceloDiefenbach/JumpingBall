//
//  ProfileView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 15/11/22.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            Color.black.ignoresSafeArea().opacity(0.6)
            
            VStack(spacing: 8) {
                
                HStack {
                    Text("Logout")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("PurplePrimary"))
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(50)
                .onTapGesture {
                    viewModel.logOut(coordinator: coordinator)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(.top, 24)
                
                Text("Delete account")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.red)
                    .padding(.vertical, 24)
                    .onTapGesture {
                        viewModel.deleteUser(coordinator: coordinator)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
            }.padding(.horizontal, 20) //defaultMargin
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
    
}
