//
//  MenuView.swift
//  BabayProtectProgram Watch App
//
//  Created by 韦小新 on 2023/8/9.
//

import SwiftUI
import WatchKit

struct MenuView: View {
    @StateObject var healthModel: HealthModel
    @StateObject var bluetool = BluetoothModel()
    @State var isContain = false
    var model = ViewModelWatch()
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                BeaconDetectView(bluetoothModel: bluetool, isContain: $isContain)
                    .sheet(isPresented: $isContain, content: {
                        WarningView()
                            .onDisappear(perform: {
                                isContain = false
                                bluetool.peripheralNames.removeAll()
                                bluetool.scanForPeripherals()
                            })
                    })
                    .opacity(0)
                VStack(spacing: 15){
                    HStack(spacing: 18){
                        NavigationLink {
                            CallPhoneView()
                        } label: {
                            MenuRow(image: "CallPhone")
                            
                        }
                        .frame(width: 75, height:75)

                        NavigationLink {
                            HealthView(healthModel: healthModel)
                        } label: {
                            MenuRow(image: "Health")
                        }
                        .frame(width: 75, height:75)
                    }
                   
                    HStack(spacing:18){
                        NavigationLink {
                           
                        } label: {
                            MenuRow(image: "Message")
                        }
                        .frame(width: 75, height:75)

                        NavigationLink {
                            
                        } label: {
                           MenuRow(image: "CallFast")
                        }
                        .frame(width: 75, height:75)
                        
                    }
                }
                .padding(.top)
                
               
            }
           
        }
        
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(healthModel: HealthModel())
    }
}
