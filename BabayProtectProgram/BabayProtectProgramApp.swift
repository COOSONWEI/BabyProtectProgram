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
        // 设置 TabBar 的外观
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = UIColor.white // 设置背景色
        print("Inite success")
//        tabBarAppearance.tintColor = UIColor.white // 设置选中项的颜色
    }
    
    
    
    @StateObject var healthModel = HealthModel()
    @StateObject var babyPhone = BabyPhoneModel()
    @StateObject var vm = CloudPushNotificationViewModel()
    @StateObject var blueModel = BluetoothModel()
    
    var body: some Scene {
        WindowGroup {
//            CustomTabView()  //主视图
//            DrawingHistoryView()  //地图测试视图
            NewCustomTabView()
            
//             FIrstEnterView()
//            NotificationTestView()//订阅测试视图
//            BeaconDetectView(bluetoothModel: blueModel)
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


