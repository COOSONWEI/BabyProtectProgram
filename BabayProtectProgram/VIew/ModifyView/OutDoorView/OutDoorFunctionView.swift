//
//  OutDoorFunctionView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/12.
//

import SwiftUI

//MARK: -地图的按钮功能
struct OutDoorFunctionView: View {
    
    @Binding var zoomLocation: Bool
    @Binding var zoomChild: Bool
    @StateObject var locatinoModel: LocationCloudStroe
    @Binding var showNavBar: Bool
    let action: () -> Void
    @State var showAlert = false
    
    var body: some View {
        ZStack{
            
            Capsule()
                .foregroundColor(.white)
                .shadow(radius: 5)
            
            
            VStack{
                Button {
                    print("locatinoModel.locationRecord.count:--\(locatinoModel.locationRecord.count)")
                    if locatinoModel.locationRecord.count > 0 {
                        zoomChild = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+1){
                            zoomChild = false
                        }
                    }else{
                        showAlert = true
                    }
                    
                } label: {
                    Image("location")
                        .resizable()
                        .frame(maxWidth: 32, maxHeight: 32)
                        .fixedSize()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("提示"), message: Text("您还未绑定AppleWatch传递位置信息，请您先绑定AppleWatch后打开'守护'App，会自动进行第一次数据同步"))
                }
                
                
              
                Text("孩子位置")
                    .font(.system(size: 9))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    .minimumScaleFactor(0.2)
                
                Divider()
                
                Button {
                    zoomLocation=true
                    DispatchQueue.main.asyncAfter(deadline: .now()+1){
                        zoomLocation = false
                    }
                    
                } label: {
                    
                    Image(systemName: "location")
                        .resizable()
                        .foregroundColor(Color(red: 108/255, green: 108/255, blue: 108/255))
                        .frame(maxWidth: 32, maxHeight: 32)
                        .fixedSize()
                }
                
                Text("您的位置")
                    .font(.system(size: 9))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    .minimumScaleFactor(0.2)
                
                Divider()
                
                Button(action: action) {
                    Image(systemName: "map")
                        .resizable()
                        .foregroundColor(Color(red: 108/255, green: 108/255, blue: 108/255))
                        .frame(maxWidth: 32, maxHeight: 32)
                        .fixedSize()
                }
                Text("前往孩子所在位置")
                    .font(.system(size: 9))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    .lineLimit(nil)
                
                
                Divider()
                
                
                Button {
                    
                    withAnimation(.spring()){
                        showNavBar.toggle()
                    }
                    
                } label: {
                    VStack{
                        Image(systemName: showNavBar ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right"  )
                            .resizable()
                            .fixedSize()
                            .foregroundColor(Color(red: 108/255, green: 108/255, blue: 108/255))
                        Text(showNavBar ? "收起" : "展开" )
                            .font(.system(size: 9))
                            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                            .lineLimit(nil)
                    }
                   
                }
               
            }
           
        }
        .frame(maxWidth: 40, maxHeight: 250)
        
    }
}

//struct OutDoorFunctionView_Previews: PreviewProvider {
//    static var previews: some View {
//        OutDoorFunctionView(zoomLocation: .constant(false), zoomChild: .constant(false))
//    }
//}
