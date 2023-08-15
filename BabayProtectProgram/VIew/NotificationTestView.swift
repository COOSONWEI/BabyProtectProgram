//
//  NotificationTestView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

struct NotificationTestView: View {
    @StateObject private var vm = CloudPushNotificationViewModel()
    var body: some View {
        VStack(spacing:   40) {
            Button {
                vm.requestNotification()
            } label: {
                Text("request notification premession")
            }
            
            Button {
                vm.subscribeToNotificatoin()
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
