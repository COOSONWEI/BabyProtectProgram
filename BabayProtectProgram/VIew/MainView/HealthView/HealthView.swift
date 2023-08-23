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
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showLoadingIndicator = false
    

    @State var fetchTrue = true
    
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
                            presentationMode.wrappedValue.dismiss()
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
               
           
//                    ExerciseCard(todayTime: healthDataModel.health.count > 0 ?  healthDataModel.health[0].object(forKey: "todayTime") as! Double : 0.0, todayCalorie: healthDataModel.health.count > 0 ? healthDataModel.health[0].object(forKey: "todayCalorie") as! Double : 0.0)
                    
                    HStack{
                        
                        WalkCard(walkStep: healthDataModel.walkStep)
                        
                        Spacer()
                        RunCard(distance: healthDataModel.distance)
                    }
                    .padding(.leading,20)
                    .padding(.trailing,20)
                
               
                        
                SleepCard(sleepTime: healthDataModel.sleepTime)
                    .padding(.leading,20)
                    .padding(.trailing,20)
               
                
                MoreInformationList(rate: healthDataModel.heartRate)
                    .padding(.leading,20)
                    .padding(.trailing,20)
                    .padding(.bottom,20)
                    .alert(isPresented: $fetchTrue) {
                        Alert(title: Text("数据同步失败"), message: Text("请在绑定的Apple Watch中开启“守护”的健康访问权限，同步您孩子的健康数据，我们将使用这些健康信息，以便您更好地了解孩子的运动情况和健康状况。"))
                          
                    }
            }
            .task {
                do {
                        try await healthDataModel.fetchRestaurants()
                    if healthDataModel.heartRate > 0 {
                        fetchTrue = false
                    }else{
                        fetchTrue = true
                    }
                        showLoadingIndicator = false
                       
                    
                    } catch {
                        // 在这里处理错误，例如打印错误信息或者显示错误提示给用户
                        print("Error fetching restaurants: \(error)")
                        showLoadingIndicator = false
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
                        showLoadingIndicator = false
                    }
                
            }
            
            if showLoadingIndicator {
                ProgressView()
            }
           
        }
        .navigationBarBackButtonHidden(true)
    }

    }
    
    


struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
