//
//  RegisterView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/26.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct RegisterView: View {
    @AppStorage("user") var user: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    
    @State var moveToMainView = false
    
    var body: some View {
        
        VStack(alignment: .center){
            
            HStack{
                BackButtonView()
                Spacer()
            }
            .padding(.leading)
            
            HStack{
                Text("开启守护")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                    .kerning(1.4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.32, green: 0.32, blue: 0.32))
                Spacer()
            }
            .padding(.leading)
            
            Spacer()
            //邮箱登录
            NavigationLink {

                EmailRegisterView()
                
            } label: {
                HStack(alignment:.center){
                    
                    Image(systemName: "envelope")
                        .foregroundColor(.white)
                    
                    Text("使用电子邮箱注册")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.leading, 68)
                .padding(.trailing, 9.25)
                .padding(.vertical, 7.70833)
                .frame(maxWidth: 276, alignment: .leading)
                .frame(maxHeight: 37.0616)
                .background(Color(red: 0.39, green: 0.57, blue: 0.76))
                .cornerRadius(38.54166)
                .shadow(color: Color(red: 0.1, green: 0.11, blue: 0.2).opacity(0.1), radius: 11.5625, x: 0, y: 15.41667)
            }
            
            //Apple注册
            SignInWithAppleButton(.signUp) { request in
                
                request.requestedScopes = [.email,.fullName]
                
            } onCompletion: { result in
                switch result {
                case .success(let auth):
                    moveToMainView = true
                    switch auth.credential {
                    case let credentail as ASAuthorizationAppleIDCredential:
                        //User ID
                        let userID = credentail.user
                        //User Info
                        let email = credentail.email
                        let firstName = credentail.fullName?.givenName
                        let lastName = credentail.fullName?.familyName
                        
                        self.user = userID
                        self.email = email ?? ""
                        self.firstName = firstName ?? ""
                        self.lastName = lastName ?? ""
                        
                    default:
                        break
                    }
                case .failure(let error):
                    print(error)
                    
                }
            }
            .frame(maxHeight: 37.0616)
            .frame(width: 276, alignment: .leading)
            .cornerRadius(38.54166)
            
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $moveToMainView) {
            NewCustomTabView()
        }
        
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
