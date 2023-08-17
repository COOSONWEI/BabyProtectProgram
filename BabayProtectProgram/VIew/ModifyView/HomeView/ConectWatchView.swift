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
    @State private var enterAddBabyphone = false
    
    @State var dataInfo = [DataInfo]()
    @State var phone = ""
    @State private var notAddPhone = false
    @State private var isNill = false
    
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
                    readData()
                    
                    if phone == "" {
                        notAddPhone = true
                    }else{
                       notAddPhone = false
                    }
                    callContact(phone)
                } label: {
                    Image(systemName: "phone.circle")
                        .resizable()
                        .frame(maxWidth: 65, maxHeight: 65)
                        .foregroundColor(.white)
                }
                .alert(isPresented: $notAddPhone) {
                    Alert(title: Text("提示"), message: Text("请添加宝贝的电话"))
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
        .alert(isPresented: $isNill) {
            Alert(title: Text("提示"), message: Text("请在Watch端打开“守护”App进行第一次数据同步"))
        }
        .onAppear(perform: {
            if DataManager.isFirstRuning() {
                print("第一次运行程序")
                isNill = true
            }else{
                isNill = false
            }
        })
        .fullScreenCover(isPresented: $enterAddDangerous) {
            AddDangerView()
        }
        .fullScreenCover(isPresented: $enterIndoorDangerous) {
            AddInDoorDangerousView()
        }
        .sheet(isPresented: $enterAddBabyphone) {
            AddBabayPhone()
                .presentationDetents([.medium,.large])
        }
    }
    
    private func readData() {
        //读孩子的电话数据
        dataInfo = DataManager.readData()
        for info in dataInfo {
            phone = info.phone
        }
    }
}

struct ConectWatchView_Previews: PreviewProvider {
    static var previews: some View {
        ConectWatchView()
    }
}
