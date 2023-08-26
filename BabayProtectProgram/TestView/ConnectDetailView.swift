//
//  ConnectDetailView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/26.
//

import SwiftUI

struct ConnectDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var uuid: String
    @Binding var name: String
    @State var newName = ""
    @StateObject var bluetoolth: BluetoothModel
    
    var body: some View {
        VStack{
            Text("UUID = \(uuid)")
            TextField("目前的UUI为\(uuid)", text: $uuid)
            TextField("目前的名称为:\(name)", text: $newName)
            
            Button {
                bluetoolth.sendATCommand("AT+NAME=\(newName)")
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("保存")
            }
            
        }
    }
    
    func saveChanges() {
        
    }
    
}

struct ConnectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectDetailView(uuid: .constant(""), name: .constant(""),bluetoolth: BluetoothModel())
    }
}
