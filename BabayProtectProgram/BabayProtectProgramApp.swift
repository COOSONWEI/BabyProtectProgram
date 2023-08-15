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
    
   
    
    var body: some Scene {
        WindowGroup {
            HomeView()
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


