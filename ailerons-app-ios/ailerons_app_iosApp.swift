//
//  ailerons_app_iosApp.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import SwiftUI

enum Screen {
    case map
    case reglages
}

final class TabRouter: ObservableObject {
    @Published var screen: Screen = .map
    
    func change(to screen: Screen) {
        self.screen = screen
    }
}

@main
struct ailerons_app_iosApp: App {

    @StateObject var router: TabRouter = .init()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $router.screen) {
                
                // Vue Carte
                MapViewWrapper()
                    .badge(10)
                    .tag(Screen.map)
                    .environmentObject(router)
                    .tabItem { Label("Carte", systemImage: "map")}


                
                // Vue Reglages
                ViewControllerWrapper()
                    .edgesIgnoringSafeArea(.top)
                    .tag(Screen.reglages)
                    .environmentObject(router)
                    .tabItem { Label("Réglages", systemImage: "gear")}


            }
            .onAppear() {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemMaterial)
                
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}
