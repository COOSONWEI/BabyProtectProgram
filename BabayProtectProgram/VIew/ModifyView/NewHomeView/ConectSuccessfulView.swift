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
    }
}

struct ConectSuccessfulView_Previews: PreviewProvider {
    static var previews: some View {
        ConectSuccessfulView()
    }
}
