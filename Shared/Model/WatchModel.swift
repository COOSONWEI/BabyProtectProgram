//
//  WatchModel.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/11.
//

import Foundation
import SwiftUI
import WatchConnectivity

class ViewModelWatch : NSObject, ObservableObject,  WCSessionDelegate{
    
    var session: WCSession
    init(session: WCSession = .default){
        self.session = session
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
   
}
