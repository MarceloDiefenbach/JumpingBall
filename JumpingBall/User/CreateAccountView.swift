//
//  CreateAccountView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 15/11/22.
//

import SwiftUI

struct CreateAccountView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var coordinator: Coordinator
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @State var isShowingLoginAlert: Bool = false
    @State var alertType: AlertCases = .success
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            Color.black.ignoresSafeArea().opacity(0.6)
            
            VStack(spacing: 8) {
                JBTextField(placeholder: "Username", email: $username, contentType: .username)
                
                JBTextField(placeholder: "E-mail", email: $email, contentType: .emailAddress)
                
                JBTextField(placeholder: "Password", email: $password, contentType: .newPassword)
                
                HStack {
                    Text("Create account")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("PurplePrimary"))
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(50)
                .onTapGesture {
                    viewModel.createAccount(username: username, email: email, password: password, completionHandler: { (alertCase) in
                        
                        if alertCase == .success {
                            coordinator.isPresentingView = .home
                        } else if alertCase == .emptyFields {
                            alertType = .emptyFields
                            isShowingLoginAlert = true
                        } else if alertCase == .invalidEmail {
                            alertType = .invalidEmail
                            isShowingLoginAlert = true
                        } else if alertCase == .defaultError {
                            alertType = .defaultError
                            isShowingLoginAlert = true
                        }
                    })
                }
                .padding(.top, 24)
                
                Text("I already have an account")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white)
                    .onTapGesture {
                        coordinator.isPresentingView = .login
                    }
                    .padding(.top, 16)
                
                HStack {
                    Text("Continue without an account")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("PurplePrimary"))
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(50)
                .onTapGesture {
                    coordinator.isPresentingView = .home
                }
                .padding(.top, 32)
                
            }.padding(.horizontal, 20) //defaultMargin
        }.alert(isPresented: $isShowingLoginAlert, content: {
            return Alert(title: Text(alertType.alertTitle),
                         message: Text(alertType.alertDescription),
                         dismissButton: .cancel(Text("Ok"), action: {
                self.isShowingLoginAlert = false
            }))
        })
    }
    
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
    
}
