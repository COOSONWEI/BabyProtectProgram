//
//  CustomBar.swift
//  BabayProtectProgram
//
//  Created by 韦小新 on 2023/8/11.
//

import SwiftUI
import UIKit
import Foundation

struct CustomTabView: View {
    
    @State var selectedIndex: Int = 0
    var body: some View {
        CustomBottomBarView(tabs: TabType.allCases.map({$0.tabItem}), selectedIndex: $selectedIndex) { index in
            let type = TabType(rawValue: index) ?? .home
            getTabView(type: type)
        }
        .padding(.bottom,-5)
        
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .home:
            HomeView()
        case .shooping:
            ShoppingView()
        }
    }
}


// 数据模型
struct TabItemData {
    let image: String
    let selectedImage: String
    let title: String
}

// ItemView 视图
struct TabItemView: View {
    let data:TabItemData
    let isSelected: Bool
    var body: some View {
        VStack {
            Image(systemName:  isSelected ? data.selectedImage : data.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .animation(.default)
                .foregroundColor(isSelected ? .black : .gray)
            Spacer()
                .frame(height: 4)
//            Text(data.title)
//                .foregroundColor(isSelected ? .black : .gray)
//                .font(.system(size: 14))
        }
//        .overlay {
//            Circle()
//                .fill(.blue)
//                .frame(width: 60,height: 60)
//                .opacity(isSelected ? 0.15 : 0)
//        }
    }
}


struct TabBottomView: View {
    let tabbarItems: [TabItemData]
    var height: CGFloat = 100
    var width: CGFloat = UIScreen.main.bounds.width
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(tabbarItems.indices) { index in
                let item = tabbarItems[index]
                
                Button {
                    selectedIndex = index
                } label: {
                    let isSelected = selectedIndex == index
              
                    TabItemView(data: item, isSelected: isSelected)
                }
                Spacer()
            }
           
        }
        .frame(width: width, height: height)
        .background(
            LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 1, green: 0.84, blue: 0.59), location: 0.00),
            Gradient.Stop(color: Color(red: 1, green: 0.52, blue: 0.58), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 1)
            ))
        .cornerRadius(20)
        .shadow(radius: 5, x: 0, y: 4)
    }
}



struct CustomBottomBarView<Content: View>: View {
    let tabs:[TabItemData]
    @Binding var selectedIndex: Int
    @ViewBuilder let content: (Int) -> Content
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(tabs.indices) { index in
                    content(index)
                        .tag(index)
                }
            }
            VStack {
                Spacer()
                TabBottomView(tabbarItems: tabs, selectedIndex: $selectedIndex)
            }
            .padding(.bottom, -30)
            
        }
    }
}

enum TabType: Int, CaseIterable {
    case home = 0
    case shooping
    
    var tabItem: TabItemData {
        switch self {
        case .home:
            return TabItemData(image: "house", selectedImage: "house.fill", title: "首页")
        case .shooping:
            return TabItemData(image: "bag", selectedImage: "bag.fill", title: "商城")
        }
    }
}


