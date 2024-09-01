//
//  SplashView.swift
//  Example
//
//  Created by Rifat Khadafy on 01/09/24.
//

import SwiftUI
import SwiftRouter

struct SplashView: View {
    @EnvironmentObject var router: Router
    
    let id: UUID
    var body: some View {
        Text("Splash Screen")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    router.pushReplace(id, "/main")
                }
            }
    }
}

#Preview {
    SplashView(id: UUID())
}
