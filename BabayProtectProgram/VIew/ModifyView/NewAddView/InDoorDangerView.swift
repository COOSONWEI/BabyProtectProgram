//
//  InDoorDangerView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct InDoorDangerView: View {
    
    @StateObject var cloudBeaconModel = CloudBeaconModel()
    
    @State private var items: [String] = ["Item 1", "Item 2", "Item 3"]
    
    @State var show = false
    @State var isValid = false
    @State var isFalse = false
    @State var showAlert = false
    //    @State private var addDangerous
    
    var body: some View {
        
        ZStack {
            VStack{
                
                List{
                    //                        cloudBeaconModel.usefulBeaconNames.keys.sorted()
                    ForEach(cloudBeaconModel.usefulbeaconsubTitle.keys.sorted(),id:\.self){ key in
                        
                        InDoorDangerousCard(name: key, subView: cloudBeaconModel.usefulbeaconsubTitle[key] ?? "")
                        
                    }
                    .onDelete(perform: deleteItem)
                    
                }
                .listStyle(.plain)
                
                AddDangerousButton(sheetView: $show)
                
            }
            AddBeaconView(show: $show, cloudModel: cloudBeaconModel,showAlert: $showAlert)
        
            Button("Show Alert") {
//                showAlert = true
            }
            .background(.black)
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Alert Title"),
                    message: Text("This is an alert message."),
                    primaryButton: .default(Text("OK")),
                    secondaryButton: .cancel()
                )
            }
            
            //                AddBeaconView(show: $show, cloudModel: cloudBeaconModel)
            //                    .offset(y: -50)
            
            
        }
        
        
        
        
        
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}


struct AddDangerousButton: View {
    @Binding var sheetView: Bool
    
    var body: some View {
        
        ZStack{
            
            
            Button {
                
                withAnimation {
                    sheetView = true
                }
                
            } label: {
                
                HStack{
                    Image("circle.badge.plus 2")
                        .resizable()
                        .frame(maxWidth: 33, maxHeight: 30)
                    
                    VStack(alignment:.leading){
                        
                        Text("危险添加")
                            .font(Font.custom("SF Pro Display", size: 17))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        Text("点击添加新信标")
                            .font(Font.custom("SF Pro Display", size: 15))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.53, green: 0.53, blue: 0.51))
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                .padding()
                .frame(maxWidth: 343)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 2, x: 4, y: 4)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 1, y: 1)
            }
            
            
            
        }
        
    }
    
}

struct InDoorDangerView_Previews: PreviewProvider {
    static var previews: some View {
        InDoorDangerView()
    }
}
