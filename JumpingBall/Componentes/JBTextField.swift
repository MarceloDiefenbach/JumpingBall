//
//  JBTextField.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 15/11/22.
//

import SwiftUI

struct JBTextField: View {
    
    @State var placeholder: String
    @Binding var email: String
    @State var contentType: UITextContentType
    
    var body: some View {
        TextField("", text: $email)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.vertical)
            .textContentType(contentType)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 1)
                    
                    if email.count == 0 {
                        HStack {
                            Text(placeholder)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            Spacer()
                      }
                     .frame(maxWidth: .infinity)
                    }
                }
            )
            .cornerRadius(10)
    }
}
