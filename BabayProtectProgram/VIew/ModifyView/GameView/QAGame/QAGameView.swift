//
//  QAGameView.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/24.
//

import SwiftUI

struct QAGameView: View {
    let qAModel =  QAModel.exampleQA
    @State private var selectedOption: Int? = nil
    
    @State private var options = ["A", "B", "C", "D"]
    
    @State var count = 0
    @State var isSuccess = false
    @State var isTrue = false
    
    var body: some View {
        VStack(alignment:.center,spacing: 20){
            
            HStack{
                BackButtonView()
                Spacer()
            }
            
            Text("SECURITY\nQ&A")
                .font(.system(size:  34))
                .fontWeight(.bold)
                .kerning(0.374)
                .foregroundColor(.black.opacity(0.66))
                .frame(maxWidth: .infinity, alignment: .topLeading)
            
            Text("知识问答(\(count+1)/\(qAModel.count))")
                .font(.system(size: 41.6))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 1, green: 0.67, blue: 0.7))
            
            Text(qAModel[count].question)
                .font(.system(size: 19.68))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                .frame(maxHeight: 51, alignment: .center)
            
            //回答问题的卡片
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                
                    .background(.white)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 4, y: 4)
                    .shadow(color: .black.opacity(0.09), radius: 4.5, x: 1, y: 1)
                
                
                VStack(alignment:.leading){
                    ForEach(0..<options.count, id: \.self) { model in
                        
                        Button {
                            optionTapped(model)
                        } label: {
                            ZStack{
                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame(height: 54)
                                  .background(Color(red: 1, green: 0.97, blue: 0.97))
                                  .cornerRadius(35)
                                  .shadow(color: .black.opacity(0.04), radius: 3.5, x: 4, y: 4)
                                  .shadow(color: .black.opacity(0.09), radius: 2, x: 1, y: 1)
                                
                                  .opacity(selectedOption == model ? 1 : 0)
                                HStack{
                                    Image(options[model])
                                    Text(qAModel[count].options[options[model]] ?? "")
                                    Spacer()
                                }
                                .padding(.leading)
                               
                            }
                        }
                        if model < 3 {
                            Divider()
                        }
                      
                        
                    }
                   
                }
                .padding()
                
            }
            .frame(maxHeight: 288)
            
            Button {
                
                isTrue = checkTheAnswer(selected: selectedOption ?? -1 )
                
            } label: {
                Text("提交答案")
                    .font(.system(size: 15.6213))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20.8284)
                    .padding(.vertical, 14.31953)
                    .frame(width: 325, alignment: .leading)
                    .background(Color(red: 1, green: 0.67, blue: 0.7))
                    .background(Color(red: 0.93, green: 0.93, blue: 0.93).opacity(0.8))
                    .cornerRadius(15.6213)
            }
            .padding(.top,40)
        }
        .padding(.leading)
        .padding(.trailing)
        
        .background(
            Image("QABG")
        )
    }
    
    func optionTapped(_ index: Int) {
            if selectedOption == index {
                selectedOption = nil
            } else {
                selectedOption = index
            }
    }
    
    func checkTheAnswer(selected: Int) -> Bool {
        if selected >= 0 {
            if qAModel[count].answer == options[selected] {
                
                if count+1 < qAModel.count {
                    count += 1
                }else{
                    //答完所有题
                    isSuccess = true
                }
                return true
            }
        }
        return false
    }
}



struct QAGameView_Previews: PreviewProvider {
    static var previews: some View {
        QAGameView()
    }
}
