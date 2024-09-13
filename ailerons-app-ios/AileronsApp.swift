//
//  ailerons_app_iosApp.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import SwiftUI

@main
struct AileronsApp: App {
    
    @StateObject var router: TabRouter = .init()
    @StateObject var speciesViewModel = SpeciesViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $router.screen) {
                // Vue Actualités
                NewsView()
                    .badge(10)
                    .tag(Screen.news)
                    .environmentObject(router)
                    .tabItem { Label("Actualités", systemImage: "newspaper") }
                
                // Vue Carte
                MapViewWrapper()
                    .tag(Screen.map)
                    .environmentObject(router)
                    .environmentObject(speciesViewModel)
                    .tabItem { Label("Carte", systemImage: "map") }
                
                // Vue liste animaux
                SpeciesView()
                    .tag(Screen.individuals)
                    .environmentObject(router)
                    .environmentObject(speciesViewModel)
                    .tabItem { Label("Individus", systemImage: "book.pages") }
                


            }
            .onAppear() {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
                
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
                
                Task {
                    if speciesViewModel.individuals.isEmpty {
                        await speciesViewModel.fetchFullDataIndividuals()
                    }
                }
            }
        }
    }
}

enum Screen {
    case map
    case reglages
    case news
    case individuals
}

final class TabRouter: ObservableObject {
    @Published var screen: Screen = .map
    
    func change(to screen: Screen) {
        self.screen = screen
    }
}
