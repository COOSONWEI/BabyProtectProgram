//
//  BabayProtectProgramApp.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import WatchConnectivity

@main
struct BabayProtectProgramApp: App {
    init() {
            // 修改全局的 List 样式
            UITableView.appearance().backgroundColor = .clear
    }
    
    @StateObject var healthModel = HealthModel()
    @StateObject var babyPhone = BabyPhoneModel()
    @StateObject var vm = CloudPushNotificationViewModel()
    
    var body: some Scene {
        WindowGroup {
//            CustomTabView()  //主视图
//            DrawingHistoryView()  //地图测试视图
            NewCustomTabView()
//            NotificationTestView()
//            StreeNameView()
                .onAppear {
                    // 获取数据
                    vm.requestNotification()
                    vm.subscribeToNotificatoin()
                }
        }
    }
    
}



class BabayProtectProgramWCSession: NSObject,WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            if let error {
                print("session activation failed with error: \(error.localizedDescription)")
            }
        }
            
        func sessionDidBecomeInactive(_ session: WCSession) {
            session.activate()
        }
        
        func sessionDidDeactivate(_ session: WCSession) {
            session.activate()
        }
}


