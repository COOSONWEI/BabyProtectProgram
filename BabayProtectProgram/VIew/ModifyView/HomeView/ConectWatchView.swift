//
//  ConectWatchView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI

struct ConectWatchView: View {
    
    @State var enterAddDangerous = false
    
    @State var enterIndoorDangerous = false
    @StateObject var babyPhone = BabyPhoneModel()
    
    @State private var enterAddBabyphone = false
    var body: some View {
        ZStack{
            //背景
            VStack{
                ZStack{
                    Image("bg_1")
                        .resizable()
                        .fixedSize()
                    
                    Image("bg_2")
                        .resizable()
                        .scaledToFit()
                        .offset(y: -15)
                }
                .ignoresSafeArea(.all)
                .edgesIgnoringSafeArea(.all)
                Spacer()
            }
            
            VStack{
                HStack{
                    Image("Avatar")
                        .resizable()
                        .frame(maxWidth: 50.54, maxHeight: 57.22)
                        .fixedSize()
                        .padding(.leading)
                    Spacer()
                }
                
                VStack(alignment:.center){
                    Text("家长监督")
                        .font(.system(size: 21))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.5)
                    
                    Text("MONITORING")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: 260)
                    
                    Text("孩子安全家长放心")
                        .font(.system(size: 13))
                        .minimumScaleFactor(0.5)
                        .kerning(10)
                        .foregroundColor(.white)
                        .frame(maxWidth: 260)
                }
                
                Button {
                    callContact(babyPhone.babyphone)
                } label: {
                    Image(systemName: "phone.circle")
                        .resizable()
                        .frame(maxWidth: 65, maxHeight: 65)
                        .foregroundColor(.white)
                }
                
                
                Text("呼叫宝贝")
                    .font(.system(size: 15))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
                
               
                VStack{
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
                   
                    HomeFunctionChooseView()
                   
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
                    
                    ScrollView(.vertical,showsIndicators: false) {
                        
                        Button {
                            enterIndoorDangerous = true
                        } label: {
                            ZStack{
                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame(width: 339, height: 73)
                                  .background(.white)
                                  .cornerRadius(17)
                                  .shadow(color: .black.opacity(0.05), radius: 4.5, x: 1, y: 1)
                                  .shadow(color: .black.opacity(0.14), radius: 6, x: 3, y: 3)
                                Text("添加室内信标")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                                  .kerning(1)
                                  .foregroundColor(Color(red: 0.31, green: 0.31, blue: 0.31))
                                  .frame(width: 297.71469, alignment: .topLeading)
                            }
                        }
                        
                        Button {
                            enterAddDangerous = true
                        } label: {
                            ZStack{
                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame(width: 339, height: 73)
                                  .background(.white)
                                  .cornerRadius(17)
                                  .shadow(color: .black.opacity(0.05), radius: 4.5, x: 1, y: 1)
                                  .shadow(color: .black.opacity(0.14), radius: 6, x: 3, y: 3)
                                Text("添加联系人")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                                  .kerning(1)
                                  .foregroundColor(Color(red: 0.31, green: 0.31, blue: 0.31))
                                  .frame(width: 297.71469, alignment: .topLeading)
                            }
                            
                        }
                        Button {
                            enterAddBabyphone = true
                        } label: {
                            ZStack{
                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame(width: 339, height: 73)
                                  .background(.white)
                                  .cornerRadius(17)
                                  .shadow(color: .black.opacity(0.05), radius: 4.5, x: 1, y: 1)
                                  .shadow(color: .black.opacity(0.14), radius: 6, x: 3, y: 3)
                                Text("添加宝贝的号码")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                                  .kerning(1)
                                  .foregroundColor(Color(red: 0.31, green: 0.31, blue: 0.31))
                                  .frame(width: 297.71469, alignment: .topLeading)
                            }
                            
                        }
                      
                    }
                   
                }
                .padding(.top,47)
                .padding(.leading,30)
                .padding(.trailing,30)
                
                Spacer()
                
            }
            
        }
        .onAppear {
            // 检测匹配状态并更新变量
            
        }
        .fullScreenCover(isPresented: $enterAddDangerous) {
            AddDangerView()
        }
        .fullScreenCover(isPresented: $enterIndoorDangerous) {
            AddInDoorDangerousView()
        }
        .sheet(isPresented: $enterAddBabyphone) {
            AddBabayPhone(babyPhone: babyPhone)
                .presentationDetents([.medium,.large])
        }
    }
}

struct ConectWatchView_Previews: PreviewProvider {
    static var previews: some View {
        ConectWatchView()
    }
}
