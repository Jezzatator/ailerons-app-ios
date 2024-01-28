//
//  SpecieDetailView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI
import Charts
import MapKit

struct SpecieDetailView: View {
    
    // State pour le fond de carte
    @State var mapStyle: Int = 0
    
    // Indiv de la fiche détaillé
    let individual: SupaIndiv
    
    // Données du chart a refacto (profondeurs, luminosité, etc) - à définir avec l'assos
    var data: [ToyShape] = [
        .init(type: "Cube", count: 5),
        .init(type: "Sphere", count: 4),
        .init(type: "Pyramid", count: 4)
    ]

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    // Titre, nom scientifique, nom vernacculaire
                    Text("\(individual.binomialName) / \(individual.commonName)")
                        .font(.title2)
                        .italic()

                }
                
                HStack {
                    // Spec de base de l'individu
                    Text("Age: \(String(individual.age))")
                    Text("Poid: \(String(individual.weight))")
                    Text("Sexe: \(individual.sex)")
                }
                .font(.title3)
                .padding(.bottom)
                
                // Carte du tracé de ses déplacement
//                MapViewControllerRepresentable(mapStyle: $mapStyle, mainMap: false)
//                    .allowsHitTesting(false)
//                    .frame(height: 200)
//                    .padding(.bottom)
                
                // Chart des données à définir
                Chart {
                    LineMark(
                        x: .value("Shape Type", data[0].type),
                        y: .value("Total Count", data[0].count)
                    )
                    LineMark(
                         x: .value("Shape Type", data[1].type),
                         y: .value("Total Count", data[1].count)
                    )
                    LineMark(
                         x: .value("Shape Type", data[2].type),
                         y: .value("Total Count", data[2].count)
                    )
                }
                    .frame(height: 200)
                    .padding(.bottom)
                
                
                // Description longue de l'individu - ajout d'image
                Text(individual.description)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
                
            }
            .padding(.top)
        }
        .navigationTitle(individual.individualName)
    }
}

// Model du chart
struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

//#Preview {
//    SpecieDetailView(individual: SupaIndiv(id: 1, individualName: "Loulou", commonName: "Nanate", binomialName: "Jezzouille", age: 69, size: 69, weight: 1312, sex: "Fluide", totalDistance: 100000, description: """
//Et deserunt sint amet id do in adipiscing sint laborum ut eiusmod ullamco officia fugiat veniam irure consectetur. Ut occaecat nisi pariatur occaecat ut elit incididunt deserunt ad mollit. Eiusmod officia laboris quis laborum non eu anim dolore pariatur reprehenderit eiusmod sit tempor exercitation eiusmod. Incididunt aliqua labore non consectetur aliqua lorem officia id eu ex reprehenderit sunt voluptate in exercitation occaecat consectetur sint. Et quis irure cupidatat adipiscing anim voluptate laboris enim ullamco aute. Velit ipsum nulla fugiat culpa exercitation ex adipiscing esse tempor culpa culpa irure tempor laborum.
//Commodo laborum lorem minim nulla lorem elit duis quis nostrud quis eu in lorem cillum aliquip. Occaecat et sunt exercitation qui fugiat enim duis dolor pariatur irure sunt. Minim enim laborum commodo officia occaecat dolor ipsum ad incididunt et. Non lorem ipsum dolore in lorem mollit excepteur labore voluptate reprehenderit laborum sunt incididunt sed amet excepteur mollit. Nostrud incididunt cupidatat consequat aliquip anim labore anim est occaecat in ad minim pariatur proident et voluptate anim commodo. Exercitation exercitation lorem et lorem ullamco esse do sunt reprehenderit sint anim laborum cillum ex culpa ullamco sit cillum.
//""", icon: 3, picture: "test.jpeg"))
//}

