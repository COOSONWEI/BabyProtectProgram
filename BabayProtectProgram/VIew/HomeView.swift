//
//  HomeView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/11.
//

import UIKit
import SwiftUI
import WatchConnectivity

struct HomeView: View {
    
    @State private var isWatchPaired = false
    @StateObject var watchModel = ViewModelPhone()
    
    var body: some View {
        
        ConectWatchView()
          
        
    }
    
    
    func openWatchAppSettings() {
        guard let watchAppURL = URL(string: "x-apple-watch://") else {
            return
        }
        
        UIApplication.shared.open(watchAppURL, options: [:]) { success in
            if !success {
                print("无法打开 Watch 应用设置")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
