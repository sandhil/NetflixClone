//
//  File.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 3/13/24.
//

import Foundation
import SwiftUI

struct Login: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                Spacer()
                
                Image("netflix")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(20)
                
                VStack {
                    
                    TextField(
                        "User name",
                        text: $viewModel.username
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top, 20)
                    
                    Divider()
                    
                    SecureField(
                        "password",
                        text: $viewModel.password
                    )
                    .padding(.top, 20)
                    
                    Divider()
                    
                    Button(
                        action: viewModel.login,
                        label: {
                            Text("Login")
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .border(Color("ForegroundColor"))
                                .foregroundColor(Color("ForegroundColor"))
                        }
                    )
                    .padding(.top, 24)
                }
                
                Spacer()
                NavigationLink {
                    Signup()
                } label: {
                    Text("Singup")
                }
                
                
            }
        }.padding([.leading, .trailing], 20)
    }
}

#Preview {
    Login()
}


