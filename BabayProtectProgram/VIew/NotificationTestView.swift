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
                vm.subscribeToNotificatoin()
                vm.sendNotification(title: "您的孩子正在危险水域附近", subtitle: "", body: "是否检查打开App查看孩子目前的位置和情况")
            } label: {
                Text("subscribe the notification")
            }
            
            Button {
                vm.unsubscribeToNotification()
            } label: {
                Text("UnSubscribe the Notification")
            }

            Button {
                vm.fetchSubscriptions { subscriptionsByID, error in
                    if let error = error {
                        print("Error fetching subscriptions: \(error.localizedDescription)")
                    } else if let subscriptionsByID = subscriptionsByID {
                        for (subscriptionID, subscription) in subscriptionsByID {
                            print("Subscription ID: \(subscriptionID)")
                            // 这里可以根据 subscriptionID 判断用户订阅了哪些通知
                            // 例如，subscriptionID == "chailds_near" 表示订阅了Beacons通知
                            // subscriptionID == "child_enter_geofencations" 表示订阅了GeoDangers通知
                        }
                    }
                }

            } label: {
                Text("check the Notification")
            }
        }
    
       
    }
}

struct NotificationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationTestView()
    }
}
