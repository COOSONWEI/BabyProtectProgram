//
//  SwiftUIView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/30.
//

import SwiftUI


struct StumbleView: View {
    
    @State var backHome = false
    @State var right = 0
    @State var next = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            ZStack{
                Image("PuzzleBG")
                    .offset(x:10,y:10)
                PuzzleView(right: $right)
            }
            
            VStack{

                Text("哪些东西存在安全隐患？")
                    .font(.system(size: 26.56))
                    .foregroundColor(Color(hex: 0x3757A4))
                    .bold()
                    .padding(.top,20)
                Spacer()
              
                HStack(spacing: 30) {
                    Button(action: {
                        
                    }, label: {
                        ZStack {
                            //Rectangle 6
                            RoundedRectangle(cornerRadius: 45.51)
                                .fill(Color(#colorLiteral(red: 1, green: 0.47623410820961, blue: 0.44416680932044983, alpha: 1)))
                            .frame(width: 62, height: 62)
                            
                            Image(systemName: "arrowshape.left")
                                .foregroundColor(Color(hex: 0xFFECCA))
                        }
                        
                    })
                   
                    ZStack {
                        //Rectangle 6
                        RoundedRectangle(cornerRadius: 45.51)
                            .fill(Color(#colorLiteral(red: 1, green: 0.47623410820961, blue: 0.44416680932044983, alpha: 1)))
                        .frame(width: 62, height: 62)
                        
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(Color(hex: 0xFFECCA))
                        
                        
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        ZStack {
                            //Rectangle 6
                            RoundedRectangle(cornerRadius: 45.51)
                                .fill(Color(#colorLiteral(red: 1, green: 0.47623410820961, blue: 0.44416680932044983, alpha: 1)))
                            .frame(width: 62, height: 62)
                            
                            Image(systemName: "house")
                                .foregroundColor(Color(hex: 0xFFECCA))
                          
                                
                            
                            
                        }
                    })
                    
                  
                    
                  
                }
                
                Text("正确:\(right)/4")
               
            }
            
        }
        .onTapGesture {
            isNext()
        }
        .fullScreenCover(isPresented: $next, content: {
            SuccessView()
        })
        
    }
    func isNext() {
        if right == 4 {
            next = true
        }
    }
}

struct StumbleView_Previews: PreviewProvider {
    static var previews: some View {
        StumbleView()
    }
}
