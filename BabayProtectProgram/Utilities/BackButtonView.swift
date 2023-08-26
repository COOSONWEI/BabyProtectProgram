//
//  BackButtonView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/25.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            // Perform back button action
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black) // Set back button color
                Text("返回")
                    .foregroundColor(.black) // Set text color
            }
        }
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
