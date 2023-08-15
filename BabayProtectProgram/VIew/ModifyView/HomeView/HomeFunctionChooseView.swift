//
//  HomeFunctionChooseView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI

struct HomeFunctionChooseView: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(spacing: 33){
                OutDoorPositionEnterModify()
                HealthEnterView()
                InDoorEnterView()
            }
        }
    }
}

struct HomeFunctionChooseView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFunctionChooseView()
    }
}
