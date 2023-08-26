//
//  DanagerousListView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI

struct DanagerousListView: View {
    @Binding var jumptotheLocation: Bool
    var body: some View {
        NavigationView{
            List{
                DangerousListCard()
                    .onTapGesture {
                        withAnimation {
                            jumptotheLocation = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now()+1){
                            jumptotheLocation = false
                        }
                    }
            }
            .listStyle(.plain)
            .navigationTitle(Text("危险水域"))
        }
        
       
        
    }
}

struct DanagerousListView_Previews: PreviewProvider {
    static var previews: some View {
        DanagerousListView(jumptotheLocation: .constant(false))
    }
}
