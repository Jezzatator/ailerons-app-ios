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
    case fav
    case individuals
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
    private let vmSupaApi = SupabaseAPI()

    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $router.screen) {
                
                //Vue Favories
                ContentView()
                    .badge(3)
                    .tag(Screen.fav)
                    .environmentObject(router)
                    .tabItem { Label("Favories", systemImage: "star")}
                
                // Vue Carte
                MapViewWrapper()
                    .tag(Screen.map)
                    .environmentObject(router)
                    .tabItem { Label("Carte", systemImage: "map")}

                // Vue liste animaux
                SpeciesView()
                    .tag(Screen.individuals)
                    .environmentObject(router)
                    .tabItem { Label("Espèces", systemImage: "book.pages")}
                
                // Vue Reglages
                PreferencesView()
                    .badge(10)
                    .tag(Screen.reglages)
                    .environmentObject(router)
                    .tabItem { Label("Actualités", systemImage: "newspaper")}
                
            }
            .onAppear() {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
                
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
                
                Task {
                    await vmSupaApi.fetch()
                }
                
            }
        }
    }
}
