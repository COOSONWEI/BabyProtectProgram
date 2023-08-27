//
//  FIrstEnterView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/22.
//

import SwiftUI

struct FIrstEnterView: View {
    @State var enterTheHomeView = false
    var body: some View {
        NavigationView{
            ZStack{
                Image("EnterBG")
                    .resizable()
                    .edgesIgnoringSafeArea(.top)
                    .ignoresSafeArea()
                
                VStack(alignment:.center) {
                    Image("EnterLogo")
                    
                    
                    Text("守护")
                        .font(.custom("SF Pro", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.14, green: 0.15, blue: 0.18))
                        .foregroundColor(Color(red: 0.14, green: 0.15, blue: 0.18))
                    
                    Text("PROTECTION")
                        .font(.custom("SF Pro", size: 25))
                        .kerning(3.75)
                        .foregroundColor(Color(red: 0.14, green: 0.15, blue: 0.18))
                    
                }
                .padding(.bottom,150)
                
                
                VStack{
                    Spacer()
                    //注册页面
                    NavigationLink {
//                        ConectSuccessfulView()
                        RegisterView()
                    } label: {
                        
                        ZStack{
                            Capsule()
                                .foregroundColor(Color(red: 0.1, green: 0.11, blue: 0.2))
                                .cornerRadius(40)
                                .frame(width: 276, height: 55, alignment: .center)
                            
                                .shadow(color: Color(red: 0.1, green: 0.11, blue: 0.2).opacity(0.1), radius: 15, x: 0, y: 20)
                            
                            Text("开启守护")
                                .font(.custom("SF Pro", size: 20))
                                .fontWeight(.bold)
                                .kerning(1.2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            
                        }
                        
                    }
                    
                    //登录页面
                    NavigationLink {
                        
                        LoginView()
                        
                    } label: {
                        Text("我已有账号")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                          .kerning(1.08)
                          .multilineTextAlignment(.center)
                          .foregroundColor(Color(red: 0.32, green: 0.32, blue: 0.32))
                        
                          .padding(.top)
                    }
                    
                }
                .padding(.bottom,100)
                
            }
        }
      
    }
}

struct FIrstEnterView_Previews: PreviewProvider {
    static var previews: some View {
        FIrstEnterView()
    }
}
