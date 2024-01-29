//
//  SpeciesViewModel.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 29/01/2024.
//

import Foundation

class SpeciesViewModel: ObservableObject {
    @Published var individuals: [SupaIndiv] = []

    let supabaseAPIClient = SupabaseAPIClient()

    func fetchFullDataIndividualsPointsGeoJSON() async {
        if self.individuals.isEmpty {
                await fetchIndividuals()
                await fetchPointGeoJSON()
        }
    }
    
    func fetchIndividuals() async {
        // Créez une instance de la requête pour récupérer les individus
        let individualRequest = IndividualRequest()

        // Appelez la fonction fetch de SupabaseAPI avec la requête
        do {
            try await supabaseAPIClient.fetch(individualRequest) { [weak self] result in
                switch result {
                case .success(let fetechedIndividuals):
                    // Mettez à jour le tableau individuals dans le ViewModel avec les résultats
                    DispatchQueue.main.async {
                        self?.individuals = fetechedIndividuals
                    }
                case .failure(let error):
                    // Gérez l'erreur en conséquence
                    print("Erreur lors de la récupération des individus : \(error.localizedDescription)")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func fetchPointGeoJSON() async {
        // Créez une instance de la requête pour récupérer les individus
        let pointGeoJSONRequest = PointGeoJSONRequest()

        // Appelez la fonction fetch de SupabaseAPI avec la requête
        do {
            try await supabaseAPIClient.fetch(pointGeoJSONRequest) { [weak self] (result: Result<[PointGeoJSON], Error>) in
                switch result {
                case .success(let fetchedPointGeoJSONRequest):
                    // Mettez à jour le tableau individuals dans le ViewModel avec les résultats
                    if let selfIndividuals = self?.individuals {
                        if let joinedData = self?.joinIndividualsToPointGeoJSON(individuals: selfIndividuals, pointsGeoJSON: fetchedPointGeoJSONRequest) {
                            DispatchQueue.main.async {
                                self?.individuals = joinedData
                            }
                        }
                    }
                case .failure(let error):
                    // Gérez l'erreur en conséquence
                    print("Erreur lors de la récupération des individus : \(error.localizedDescription)")
                }
            }
        } catch {
            print(error)
        }
    }

    
    func joinIndividualsToPointGeoJSON(individuals: [SupaIndiv], pointsGeoJSON: [PointGeoJSON]) -> [SupaIndiv]? {
        return individuals.map { indiv in
            SupaIndiv(
                id: indiv.id,
                individualName: indiv.individualName,
                commonName: indiv.commonName,
                binomialName: indiv.binomialName,
                age: indiv.age,
                size: indiv.size,
                weight: indiv.weight,
                sex: indiv.sex,
                totalDistance: indiv.totalDistance,
                description: indiv.description,
                icon: indiv.icon,
                picture: indiv.picture,
                pointsGeoJSON: pointsGeoJSON.filter { $0.individualID == indiv.id },
                linesGeoJSON: []
            )
        }
    }
}
