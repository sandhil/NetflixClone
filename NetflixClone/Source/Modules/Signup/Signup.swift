//
//  File.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 3/13/24.
//

import Foundation
import SwiftUI

struct Signup: View {
    
    @ObservedObject var viewModel: SingupViewModel = SingupViewModel()
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("netflix")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding(20)
            
            VStack {
                
                TextField(
                    "First name",
                    text: $viewModel.firstName
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                
                TextField(
                    "Last name",
                    text: $viewModel.lastName
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                TextField(
                    "User name",
                    text: $viewModel.username
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                
                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                .padding(.top, 20)
                
                Divider()
                
                Button(
                    action: viewModel.signup,
                    label: {
                        Text("Signup")
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .border(Color("ForegroundColor"))
                            .foregroundColor(Color("ForegroundColor"))
                    }
                )
                .padding(.top, 24)
            }
            
            Spacer()
            
            
        }
        .padding(30)
    }
}

#Preview {
    Signup()
}


