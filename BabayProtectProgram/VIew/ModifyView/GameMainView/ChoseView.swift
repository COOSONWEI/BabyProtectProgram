//
//  ChoseView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/25.
//

import SwiftUI

//抽象一个类存放选择的图片的效果
struct ChoseImage {
    
    var imageName: String
    var isCenter: Bool
    
    static let exampleImage = [ChoseImage(imageName: "Monster_3", isCenter: false),
                               ChoseImage(imageName: "Monster_1", isCenter: true),
                               ChoseImage(imageName: "Monster_2", isCenter: false)
    ]
    
}

let screenWidth = (UIScreen.main.bounds.width - 40 - 50) / 3

struct ChoseView: View {
    
    //创建移动的属性，判断屏幕的宽度进行实现移动的效果
    @State var effect = 1
    @State var Images = ChoseImage.exampleImage
    @State var selectedImage = 1
    
    var body: some View {

            VStack{
                HStack{
                    
                    Image("\(Images[(selectedImage - 1) < 0 ? 2 : selectedImage - 1].imageName)")
                        .opacity(0.5)
                    
                    Image("\(Images[selectedImage].imageName)")
                    
                    
                    Image("\(Images[selectedImage + 1 > 2 ? 0 : selectedImage + 1].imageName)")
                        .opacity(0.5)
                    
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            
                            if value.translation.width < 0 {
                                // Swiped left
                                withAnimation(.linear) {
                                    
                                    if selectedImage + 1 > 2 {
                                        selectedImage = 0
                                    }else{
                                        selectedImage = selectedImage + 1
                                    }
                                  
                                }
                                print("selectedImage = \(selectedImage)")
                                
                                
                            } else if value.translation.width > 0 {
                                // Swiped right
                               
                                withAnimation(.linear){
                                    
                                    if selectedImage - 1 < 0 {
                                        selectedImage = 2
                                    }else{
                                        selectedImage = selectedImage - 1
                                    }
                                }
                                print("selectedImage = \(selectedImage)")
                            }
                        }
                )
                
                Text("滑动选择关卡")
                    .font(.system(size: 35))
                    .kerning(1.05)
                  .fontWeight(.bold)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 82/255, green: 82/255, blue: 82/255))
                
                Text("点击下方白色按钮进入")
                .font(.system(size: 17))
                .kerning(1.6)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.32, green: 0.32, blue: 0.32))
                  .padding(.top)
                
                ZStack{
                    
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(.white.opacity(0.68))
                            .cornerRadius(31.33876)
                            .shadow(color: .black.opacity(0.07), radius: 2.5071, x: 5.0142, y: 5.0142)
                        
                    //移动位置
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: 110, maxHeight: 110)
                        .background(.white.opacity(0.8))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.07), radius: 2.5071, x: 5.0142, y: 5.0142)

                        .offset(x: CGFloat(CGFloat((selectedImage - 1)) * screenWidth))
                    
                        
                    HStack(alignment: .center,spacing:50){
                        
                        VStack{
                            Image("Pass_1")
                            Text("游戏冒险")
                        }
                        
                        VStack{
                            Image("Pass_2")
                            Text("知识问答")
                        }
                        
                        VStack{
                            Image("Pass_3")
                            Text("AR互动")
                        }
                
                    }
                
                }
                .frame(maxHeight: 153)
                .padding(.leading)
                .padding(.trailing)
            }
        
    }
    
}

struct ChoseView_Previews: PreviewProvider {
    static var previews: some View {
        ChoseView()
    }
}
