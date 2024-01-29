//
//  MovebankFetch.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 12/01/2024.
//

import Combine
import Foundation

class MovebankFetch: ObservableObject {
    @Published var fetchedIndividuals: [Individual] = []
    @Published var individual: [Individual] = []

    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchData(completion: @escaping () -> Void)  {
        guard let url = URL(string: "https://www.movebank.org/movebank/service/public/json?&study_id=2911040&max_events_per_individual=60&sensor_type=gps") else {
            print("Error creating URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching URL data: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] data in
                self?.parse(json: data)
                completion()
            })
            .store(in: &cancellables)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonIndividuals = try? decoder.decode(Individuals.self, from: json) {
            fetchedIndividuals = jsonIndividuals.individuals
            individual = Array(fetchedIndividuals.prefix(10))
        } else {
            print("Error decode JSON")
        }
    }
    
}
