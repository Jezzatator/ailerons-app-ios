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
    @StateObject var speciesViewModel = SpeciesViewModel(dataService: DataService(configuration: SupabaseConfiguration()))
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $router.screen) {
                TabSection {
                    // Vue Actualités
                    Tab("Actualités", systemImage: "newspaper", value: Screen.news) {
                        NewsView()
                            .environmentObject(router)
                    }
                    .badge(10)

                    
                    // Vue Carte
                    Tab("Carte", systemImage: "map", value: Screen.map) {
                        MapView()
                            .environmentObject(router)
                            .environmentObject(speciesViewModel)
                    }
                    
                    // Vue Actualités
                    Tab("Individu", systemImage: "fish", value: Screen.individuals) {
                        NewsView()
                            .environmentObject(router)
                    }
                    .badge(10)
                }
                
                TabSection {
                    // About View
                    Tab("À propos", systemImage: "info.circle", value: Screen.about, role: .search) {
                        Text("About")
                            .environmentObject(router)
                            .environmentObject(speciesViewModel)
                    }
                }
            }
            .tabViewStyle(.sidebarAdaptable)
            .tabBarMinimizeBehavior(.onScrollDown)
            .onAppear() {
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
    case about
}

final class TabRouter: ObservableObject {
    @Published var screen: Screen = .map
    
    func change(to screen: Screen) {
        self.screen = screen
    }
}
