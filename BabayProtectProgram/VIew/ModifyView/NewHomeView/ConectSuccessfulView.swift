//
//  ConectSuccessfulView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct ConectSuccessfulView: View {
    
    @State var isValid = false
    @State var isFalse = false
    @State private var isNil = false
    
    var body: some View {
        
        NavigationView{
            ZStack{
                
                Image("NewBG")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(spacing:20){
                    
                    CallPhoneButtonView()
                    
                    HStack{
                        Text("功能概览")
                            .font(
                                .system(size: 20)
                            )
                            .fontWeight(.bold)
                            .kerning(6)
                            .foregroundColor(Color(red: 1, green: 0.56, blue: 0.6))
                            .frame(width: 163, alignment: .topLeading)
                        Spacer()
                    }
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        
                        HStack(spacing: 33){
                            
                            NavigationLink {
                                OutDoorMainView()
                            } label: {
                                OutDoorPositionEnterModify()
                            }
                            
                            NavigationLink {
                                HealthView()
                            } label: {
                                HealthEnterView()
                            }
                            
                        }
                        
                    }
                    
                    HStack{
                        Text("添加")
                            .font(
                                .system(size: 20)
                            )
                            .fontWeight(.bold)
                            .kerning(6)
                            .foregroundColor(Color(red: 1, green: 0.56, blue: 0.6))
                            .frame(width: 163, alignment: .topLeading)
                        Spacer()
                        
                    }
                    
                 
                        NavigationLink {
                            InDoorDangerView()
                                .navigationTitle("室内危险")
                        } label: {
                            AddButton(name: "添加室内信标")
                        }
                        .frame(maxHeight: 50)

                    
                    Divider()
                        NavigationLink {
                            
                            ContactAddView()
                                .navigationTitle("联系人")
                            
                        } label: {
                            AddButton(name: "添加联系人")
                        }
                        .frame(maxHeight: 50)
                        
                        
                        
                    
                   
                    
                    
                }
                .padding(.leading,22)
                .padding(.trailing,22)
                
            }
            .navigationTitle(Text("家长监督"))
            
        }
        .alert(isPresented: $isNil, content: {
            
            Alert(title: Text("提示"), message: Text("第一次使用本软件，请确认您的手机绑定了Apple Watch。\n 若绑定请打开Watch端“守护”App进行第一次数据同步"))
        })
        .onAppear {
            if DataManager.isFirstRuning(){
                print("第一次运行软件")
                isNil = true
            }else{
                isNil = false
            }
        }
    }
}

struct ConectSuccessfulView_Previews: PreviewProvider {
    static var previews: some View {
        ConectSuccessfulView()
    }
}
