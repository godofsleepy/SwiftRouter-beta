//
//  ExampleApp.swift
//  Example
//
//  Created by Rifat Khadafy on 01/09/24.
//

import SwiftUI
import SwiftRouter

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationRouter(rootPath: Route(path: "/")){ route in
                if(route.path == "/main"){
                    MainView(id: route.id)
                }
                else if (route.path == "/") {
                    SplashView(id: route.id)
                }
                else if (route.path == "/detail") {
                    DetailView(
                        id: route.id,
                        color: route.param!["color"] as! Color,
                        colorName:  route.param!["colorName"] as! String)
                }
                else {
                    SplashView(id: route.id)
                }
            }
        }
    }
}
