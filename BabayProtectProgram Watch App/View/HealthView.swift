//
//  HealrhView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import HealthKit

struct HealthView: View {
    
    //MARK: -健康数据模型导入
    @StateObject var healthModel: HealthModel
    
    var body: some View {
        VStack{
            
            HStack{
                HealthWalkView(step: healthModel.walkStep ?? 0)
                
                HealthRunView(distance: healthModel.distance ?? 0.0)
            }
            
            HStack{
                HealthHeartView(rate: healthModel.heartRate ?? 0)
                HealthRestingheartRateView(rate: healthModel.RestingHeartRate ?? 0)
            }
            
            SleepView(sleepTime: healthModel.sleepTime)
        }
        .navigationTitle("健康检测")
       
    }
    
   
    
   
    
    
}


struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView(healthModel: HealthModel())
    }
}
