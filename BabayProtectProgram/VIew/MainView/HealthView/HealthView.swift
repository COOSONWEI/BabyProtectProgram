//
//  HealthView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/13.
//

import SwiftUI

//MARK: -健康检测界面
struct HealthView: View {
    //数据
    @StateObject var healthDataModel: HealthiCloudStore = HealthiCloudStore()
    
    @State private var showLoadingIndicator = false
    
    @State var back = false
    var body: some View {
        ZStack{
            
            VStack{
                Image("DnagerousBG")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.top)
                    .edgesIgnoringSafeArea(.leading)
                    .edgesIgnoringSafeArea(.trailing)
                   
                Spacer()
            }
            
         
            VStack{
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
                        Text("健康检测")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.2)
                          .foregroundColor(.white)
                          .frame(width: 248, alignment: .topLeading)
                        Spacer()
                    }
                    .padding(.leading,30)
                }
               
                HStack{
                    ExerciseCard(todayTime: healthDataModel.health.count > 0 ?  healthDataModel.health[0].object(forKey: "todayTime") as! Double : 0.0, todayCalorie: healthDataModel.health.count > 0 ? healthDataModel.health[0].object(forKey: "todayCalorie") as! Double : 0.0)
                    
                    VStack{
                        
                        WalkCard(walkStep: healthDataModel.health.count > 0 ? healthDataModel.health[0].object(forKey: "walkStep") as! Int : 0)
                        
                        RunCard(distance: healthDataModel.health.count > 0 ? healthDataModel.health[0].object(forKey: "distance") as! Double : 0.0)
                    }
                }
               
                        
                SleepCard(sleepTime: healthDataModel.health.count > 0 ? healthDataModel.health[0].object(forKey: "sleepTime") as! Double : 0)
                    .padding(.leading,20)
                    .padding(.trailing,20)
               
                
                MoreInformationList(rate: healthDataModel.health.count > 0 ? healthDataModel.health[0].object(forKey: "heartRate") as! Int : 0)
                    .padding(.leading,20)
                    .padding(.trailing,20)
                    .padding(.bottom,20)
            }
            .task {
                do {
                        try await healthDataModel.fetchRestaurants()
                        showLoadingIndicator = false
//                    print("walkStep:\(String(describing: healthDataModel.health[0].object(forKey: "walkStep")))")
//                    print("sleepTime\(String(describing: healthDataModel.health[0].object(forKey: "sleepTime")))")
                    
                    } catch {
                        // 在这里处理错误，例如打印错误信息或者显示错误提示给用户
                        print("Error fetching restaurants: \(error)")
                    }
            }
            .onAppear() {
                showLoadingIndicator = true
            }
            .refreshable {
                do {
                        try await healthDataModel.fetchRestaurants()
                        showLoadingIndicator = false
                    } catch {
                        // 在这里处理错误，例如打印错误信息或者显示错误提示给用户
                        print("Error fetching restaurants: \(error)")
                    }
                
            }
            
            if showLoadingIndicator {
                ProgressView()
            }
           
        }
        
        .fullScreenCover(isPresented: $back) {
            CustomTabView()
        }
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
