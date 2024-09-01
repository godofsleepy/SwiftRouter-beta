//
//  DetailView.swift
//  Example
//
//  Created by Rifat Khadafy on 01/09/24.
//

import SwiftUI
import SwiftRouter

struct DetailView: View {
    @EnvironmentObject var router: Router
    
    let id: UUID
    let color: Color
    let colorName: String
    
    var body: some View {
        Button(action: {
            router.pop(result: color)
        }, label: {
            Text("Change Main To \(colorName)")
        })
    }
}

#Preview {
    DetailView(id: UUID(), color: Color.red, colorName: "RED")
}
