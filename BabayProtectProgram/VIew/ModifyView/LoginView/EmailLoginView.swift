//
//  EmailLoginView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/25.
//

import SwiftUI

struct EmailLoginView: View {
    @State private var selectedField: FieldType = .email
    @State private var email = ""
    @State private var password = ""
    @State var enter = false
    
    enum FieldType {
        case email
        case password
    }
    
    var body: some View {
        
        VStack{
            HStack{
                BackButtonView()
                Spacer()
            }
           
            HStack{
                
                Image("letter")
                
                TextField("电子邮箱", text: $email)
                    .padding()
                    .cornerRadius(10)
                    .onTapGesture {
                        selectedField = .email
                    }
            }
            
            Rectangle()
                .foregroundColor(.clear)
                .background(selectedField == .email ? Color(red: 1, green: 0.6, blue: 0.61) : Color(red: 0.93, green: 0.94, blue: 0.96))
                .frame(maxHeight: 2)
            
            HStack{
                Image("lock")
                SecureField("密码", text: $password)
                    .padding()
                    .cornerRadius(10)
                    .onTapGesture {
                        selectedField = .password
                    }
                
               
            }
            
            Rectangle()
                .foregroundColor(.clear)
                .background(selectedField == .password ? Color(red: 1, green: 0.6, blue: 0.61) : Color(red: 0.93, green: 0.94, blue: 0.96))
                .frame(maxHeight: 2)
            
            Spacer()
            
            Button{
                enter = checkTheLogin(email: email, password: password)
            }label: {
                HStack(alignment: .center) {
                    
                    
                    Spacer()
                    
                    Text("登录")
                        .foregroundColor(.white)
                    Spacer()
                    
                    
                }
                .padding(.horizontal, 69)
                .padding(.vertical, 7)
                .frame(maxWidth: 276, alignment: .center)
                .background(Color(red: 0.39, green: 0.57, blue: 0.76))
                .cornerRadius(38.54166)
                .shadow(color: Color(red: 0.1, green: 0.11, blue: 0.2).opacity(0.1), radius: 11.5625, x: 0, y: 15.41667)
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $enter, content: {
            NewCustomTabView()
        })
        
    }
    
    //判断输入
    func checkTheLogin(email: String, password: String) -> Bool {
        if email != "" && password != "" {
            return true
        }
        return false
    }
}

struct EmailLoginView_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginView()
    }
}
