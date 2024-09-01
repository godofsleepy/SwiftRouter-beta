//
//  MainView.swift
//  Example
//
//  Created by Rifat Khadafy on 01/09/24.
//

import SwiftUI
import SwiftRouter

struct MainView: View {
    @EnvironmentObject var router: Router
    
    let id: UUID
    let colors: [(colorName: String, color: Color)] = [
        (colorName: "Red", color: .red),
        (colorName: "Blue", color: .blue),
        (colorName: "Green", color: .green),
        (colorName: "Yellow", color: .yellow),
        (colorName: "Orange", color: .orange),
        (colorName: "Purple", color: .purple),
        (colorName: "Pink", color: .pink),
        (colorName: "Gray", color: .gray)
    ]
    
    @State var backgroundColor: Color?
    
    var body: some View {
        NavigationView {
            List(colors, id: \.colorName) { colorItem in
                HStack {
                    Circle()
                        .fill(colorItem.color)
                        .frame(width: 20, height: 20)
                    
                    Text(colorItem.colorName)
                        .foregroundColor(colorItem.color)
                }         
                .onTapGesture {
                    router.push(id, "/detail", param: ["color": colorItem.color, "colorName": colorItem.colorName]){ result in
                        self.backgroundColor = result as? Color
                    }
                }
                .background(backgroundColor)
            }
            .navigationTitle("Color List")
        }
    }}

#Preview {
    MainView(id: UUID())
}
