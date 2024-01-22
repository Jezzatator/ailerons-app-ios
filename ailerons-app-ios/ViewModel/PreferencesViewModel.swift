//
//  PreferencesViewModel.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 18/01/2024.
//

import Foundation

class PreferencesViewModel: ObservableObject {
    @Published var selectedUnit: UnitOfMeasurement

        init() {
            if #available(iOS 16.0, *) {
                let usesMetricSystem = Locale.current.usesMetricSystem
                selectedUnit = usesMetricSystem ? .metric : .imperial
            } else {
                // Fallback for earlier iOS versions
                let usesMetricSystem = Locale.current.usesMetricSystem
                selectedUnit = usesMetricSystem ? .metric : .imperial
            }
        }

        func savePreferences() {
            // Add code to save preferences if needed
        }
   }

enum UnitOfMeasurement: String, CaseIterable {
    case metric = "Métrique"
    case imperial = "Impérial"
}
