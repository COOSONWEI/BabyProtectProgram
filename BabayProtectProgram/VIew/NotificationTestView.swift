//
//  NotificationTestView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct NotificationTestView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var vm = CloudPushNotificationViewModel()
    @State var healthCount = 0
    @StateObject private var healthModel = HealthiCloudStore()
    
    var body: some View {
        VStack(spacing:   40) {
            Button {
                vm.requestNotification()
            } label: {
                Text("request notification premession")
            }
            
            Button {
//                vm.subscribeToNotificatoin()
                vm.sendNotification(title: "这是一个通知", subtitle: "测试用的", body: "具体内容不知道了")
            } label: {
                Text("subscribe the notification")
            }
            
            Button {
                vm.unsubscribeToNotification()
            } label: {
                Text("UnSubscribe the Notification")
            }

        }
    
       
    }
}

struct NotificationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationTestView()
    }
}
