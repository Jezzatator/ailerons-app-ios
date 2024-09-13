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
    let individual: SupaIndivElement
    
    var data: [ToyShape] = [
        .init(type: "Cube", count: 5),
        .init(type: "Sphere", count: 4),
        .init(type: "Pyramid", count: 4)
    ]
    
    var body: some View {
        ScrollView {
            VStack{
                VStack{
                    Image("mobula_mobular_default")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width ,height: 220)
                        .clipped()
                        .edgesIgnoringSafeArea(.horizontal)
                    
                }
                
                VStack(spacing: 2) {
                    HStack(alignment: .center) {
                        TitleText(text: individual.individualName)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            CaptionText(text: individual.commonName)
                            CaptionText(text: individual.binomialName, isItalic: true)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    Divider()
                        .background(Color.black)
                }.frame(width: UIScreen.main.bounds.width - 20)
                
                HStack(alignment: .center) {
                    DetailView(
                        detailType: .sex,
                        text: individual.sex,
                        imageName: "gender_female"
                    )
                    Spacer()
                    DetailView(
                        detailType: .wingspan,
                        text: "8 mètres",
                        imageName: "ruler.fill",
                        rotationDegrees: 45
                    )
                    Spacer()
                    DetailView(
                        detailType: .groupSituation,
                        text: "Seul.e",
                        imageName: "person.2.fill"
                    )
                }.frame(width: UIScreen.main.bounds.width - 20)
                
                VStack(alignment: .leading, spacing: 2) {
                    Group {
                        Text("Comportement*")
                            .fontWeight(.thin)
                        Text("Sautait hors de l’eau et jouait dans les vagues.")
                            .multilineTextAlignment(.leading)
                            .fontWeight(.regular)
                    }
                    
                    Group {
                        Text("Description")
                            .fontWeight(.thin)
                        
                        Text("""
                            Repérée au large du Cap Corse, il s’agit d’une femelle adulte, en parfaite santé et qui se laisse facilement approcher. \(individual.description)
                            """)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.regular)
                    }
                    
                    Text("Parcours individuel du 21/07/2023 au 17/09/2023")
                        .fontWeight(.thin)
                }
                
                if let polyline = createPolyline(for: individual.featureCollection) {
                    MapSnapshotView(polylines: [polyline])
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 20, height: 220)
                        .cornerRadius(10)
                }
                
                Text("*Au moment de la pose de balise")
                    .font(Font.system(size: 12).italic())
                    .fontWeight(.thin)
                    .multilineTextAlignment(.trailing)
                    .frame(maxWidth: UIScreen.main.bounds.width - 20, alignment: .bottomTrailing)
                
                Spacer()
            }.padding(.horizontal)
        }
        .navigationTitle("Fiche d'identité")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var chartView: some View {
        Chart {
            ForEach(data) { shape in
                LineMark(
                    x: .value("Shape Type", shape.type),
                    y: .value("Total Count", shape.count)
                )
            }
        }
        .frame(height: 200)
        .padding(.bottom)
    }
    
    private func createPolyline(for featureCollection: FeatureCollection?) -> MKPolyline? {
        guard let coordinates = featureCollection?.features.compactMap({ $0.geometry.coordinates }) else {
            return nil
        }
        
        let polylineCoordinates = coordinates.map {
            CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
        }
        
        return MKPolyline(coordinates: polylineCoordinates, count: polylineCoordinates.count)
    }
}



// Model du chart
struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

#Preview {
    SpecieDetailView(individual: SupaIndivElement(
        id: 123,
        createdAt: "2024-01-16T12:34:56Z",
        individualName: "Poupette",
        commonName: "Diable de mer méditerranéen",
        binomialName: "Mobula mobular",
        sex: "Femelle",
        description: """
               Et deserunt sint amet id do in adipiscing sint laborum ut eiusmod ullamco officia fugiat veniam irure consectetur. Ut occaecat nisi pariatur occaecat ut elit incididunt deserunt ad mollit. Eiusmod officia laboris quis laborum non eu anim dolore pariatur reprehenderit eiusmod sit tempor exercitation eiusmod. Incididunt aliqua labore non consectetur aliqua lorem officia id eu ex reprehenderit sunt voluptate in exercitation occaecat consectetur sint.
               """,
        featureCollection: FeatureCollection(
            type: "FeatureCollection",
            features: [
                Feature(
                    type: .feature,
                    geometry: Geometry(
                        type: .point,
                        coordinates: [48.8566, 2.3522] // Coordonnées fictives (Paris)
                    ),
                    properties: Properties(
                        individualID: 123,
                        individualName: "Poupette",
                        timestamp: "2024-01-16T12:34:56Z"
                    )
                )
            ]
        )
    ))
}
