//
//  AddBeaconView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/23.
//

import SwiftUI

struct AddBeaconView: View {
    
    @State var beaconName = ""
    @State var beaconSubName = ""
    @Binding var show: Bool
    @StateObject var cloudModel: CloudBeaconModel
    @State var isValid: Bool = false
    @Binding var showAlert:Bool
    @Binding var stateType: StateType
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
            
                .background(Color(red: 0.97, green: 0.99, blue: 1))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.97, green: 0.99, blue: 1), lineWidth: 1)
                )
            
            VStack(alignment:.center){
                Text("室内危险区域添加")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.13, green: 0.19, blue: 0.25))
                
                Text("请输入信标的名称和危险类型")
                    .font(Font.custom("Space Grotesk", size: 15))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.45, green: 0.51, blue: 0.59))
                    .frame(width: 285, alignment: .top)
                
                Image("Beacon")
                
                Text("危险信标命名和类型")
                    .font(Font.custom("Space Grotesk", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.45, green: 0.51, blue: 0.59))
                
                VStack{
                    
                    TextField("输入信标名称", text: $beaconName)
                        .multilineTextAlignment(.center)
                    
                    TextField("输入危险警告", text: $beaconSubName)
                        .multilineTextAlignment(.center)
                    
                }
                
                HStack{
                    Button {
                        
                        withAnimation {
                            
                            show = false
                            isValid = true
//                                                        showAlert = true
                        }
                        
                        print("isValid\(isValid)")
                        
                    } label: {
                        Text("取消")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: 135)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.13, green: 0.19, blue: 0.25), lineWidth: 1)
                                    .cornerRadius(8)
                            )
                    }
                    
                    Button {
                        showAlert = true
                        withAnimation {
                            
                            if  addBeacons(name: beaconName, subTitle: beaconSubName) {
                                show = false
                                stateType = .addSuccess
                                
                            }else{
                                isValid = true
                                stateType = .addFalse
                            }
                        }
//                        print("isFalseEnter\(isTrueEnter)")
                        
                    } label: {
                        Text("确定添加")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: 135)
                            .background(Color(red: 0.99, green: 0.65, blue: 0.64))
                            .cornerRadius(8)
                    }
                    
                }
                
                
            }
            
        }
        .frame(maxWidth: 334, maxHeight: 418)
        .background(.clear)
       
        
    }
    
    func addBeacons(name: String, subTitle: String) -> Bool {

        if name != "" {
            
            let beaconModel = BeaconModel()
            beaconModel.beaconName = Beacon(name: name, subTitle: subTitle)
            
            let cloudStore = CloudBeaconModel()
            cloudStore.saveNewBeaconToCloud(beaconModel: beaconModel)
            print("add True")
            
            stateType = .addSuccess
            return true
            
        }else{
            isValid = true
            
            stateType = .addFalse
            
            return false
        }
    }
}

struct AddBeaconView_Previews: PreviewProvider {
    static var previews: some View {
        AddBeaconView(show: .constant(false), cloudModel: CloudBeaconModel(),showAlert: .constant(false), stateType: .constant(.addFalse))
    }
}
