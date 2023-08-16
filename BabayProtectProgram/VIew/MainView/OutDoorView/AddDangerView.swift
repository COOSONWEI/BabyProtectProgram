//
//  AddDangerView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI

struct AddDangerView: View {
    @State var back = false
    @State private var isLoading = false
    @StateObject var phoneModel: Contacts = Contacts()
    
    var body: some View {
        
        ZStack {
            VStack{
                    ZStack {
                        VStack{
                            Image("DnagerousBG")
                                .resizable()
                                .edgesIgnoringSafeArea(.top)
                                .fixedSize()
                            Spacer()
                        }
                        
                        VStack{
                            HStack{
                                VStack(alignment:.leading){
                                    Text("请添加家长\n的电话")
                                        .font(.system(size: 30))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .minimumScaleFactor(0.2)
                                    
                                    Text("我们将会将联系人号码\n同步到您孩子的手表中")
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .minimumScaleFactor(0.2)
                                        .padding(.top)
                                    Spacer()
                                }.padding(.trailing,30)
                                    .padding(.leading)
                                VStack{
                                    Image("Danger")
                                        .resizable()
                                        .frame(maxWidth: 20, maxHeight: 114.29)
                                        .fixedSize()
                                    Spacer()
                                }
                                
                            }
                            
                        }
                      
                        VStack{
                            HStack{
                                Button {
                                    back.toggle()
                                } label: {
                                    Image("dgBackBT")
                                        .resizable()
                                        .frame(maxWidth: 27, maxHeight: 27)
                                        .fixedSize()
                                }
                                Spacer()
                            }
                            .padding(.leading,30)
                            Spacer()
                        }
                    }
                    //添加了危险区的卡片（这里先放一个卡片测试）
                    ScrollView{
                        ForEach(phoneModel.contacts,id: \.self){ data in
                            DangerGeofenceCard(name: data.name, phone: data.phoneNumber)
                        }
                        
                    }
                    .padding(.top,-150)
                   
                DangerButtonView(contacts: phoneModel)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                }
                .task {
                    do {
                        try await phoneModel.fetchContacts()
                        isLoading = false
                    }catch {
                        print("lodingError")
                    }
                }
                .refreshable {
                    do {
                        try await phoneModel.fetchContacts()
                        isLoading = false
                    }catch {
                        print("lodingError")
                    }
                }
                .onAppear(perform: {
                    isLoading = true
                })
                .fullScreenCover(isPresented: $back) {
                    HomeView()
            }
            
            if isLoading {
                ProgressView()
            }
        }
        
        
      
    }
        
}

struct AddDangerView_Previews: PreviewProvider {
    static var previews: some View {
        AddDangerView()
    }
}
