//
//  AddBeaconButton.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/16.
//

import SwiftUI

//MARK: -添加危险信标按钮
struct AddBeaconButton: View {
    
    @State private var enterAddBeacon = false
    @StateObject var beaconModel: BeaconModel
    @StateObject var cloudModel: CloudBeaconModel
    
    var body: some View {
        Button {
            enterAddBeacon.toggle()
        } label: {
            ZStack{
                Rectangle()
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.17), radius: 6.5, x: 3, y: 3)
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 1, y: 1)
                
                HStack{
                    
                    LinearColorText(text: "添加危险区域信标", colors: [Color(red: 255/255, green: 131/255, blue: 149/255),
                                                            Color(red: 255/255, green: 131/255, blue: 149/255)
                                                    ])
                    Spacer()
                    Image("AddBT")
                        .resizable()
                        .frame(maxWidth: 31.26496, maxHeight: 31)
                        .fixedSize()
                }
                .padding()
                
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .frame(maxHeight: 64)
        .sheet(isPresented: $enterAddBeacon) {
            EnterBeaconView(beaconModel: beaconModel, cloudModel: cloudModel)
                .presentationDetents([.medium,.large])
        }
    }
}


struct AddBeaconButton_Previews: PreviewProvider {
    static var previews: some View {
        AddBeaconButton(beaconModel: BeaconModel(), cloudModel: CloudBeaconModel())
    }
}
