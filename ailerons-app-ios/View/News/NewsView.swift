//
//  NewsView.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 11/09/2024.
//

import SwiftUI

struct NewsView: View {
    
    @State private var selectedCategory: Category? = nil
       
    let categories: [Category?] = [.unknown, .event]
    
    let articles: [Article] = [
        Article(title: "Tribune : Vers un titanic diplomatique ?", author: "Equipe Ailerons", date: Date(), categories: [.unknown], description: "À l’occasion de la Journée mondiale des océans 2024, nous avons co-signé une tribune avec 51 autres ONG et organisations. Car il nous reste 1 an.", text: "Un an. C’est le temps qu’il reste à la France pour éviter un naufrage diplomatique devant les chefs d’État du monde entier qui se réuniront à Nice dans un an jour pour jour à l’occasion de la conférence de l’ONU sur l’océan. Car la France, deuxième puissance maritime mondiale, qui n’a de cesse de protéger les lobbies de la pêche plutôt que l’océan, doit urgemment balayer devant sa porte et faire preuve de cohérence avant d’aller donner des leçons au reste du monde. Ces dernières semaines, ce sont d’ailleurs plus de 45 000 citoyen·nes et plus de 120 ONG et collectifs qui se sont réunis au sein de la « coalition citoyenne pour la protection de l’océan » autour d’une feuille de route à mettre en œuvre de toute urgence pour conjurer l’effondrement de la vie océanique.", image: "mobula_mobular_default"),
        Article(title: "Venez découvrir les nouvelles espèces du littoral méditerranéen le 09 septembre !", author: "Equipe Ailerons", date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, categories: [.event], description: "Cet été, de nombreuses sorties « Biolit, les nouveaux arrivants » sont  animées par nos membres !", text: """
                Savez-vous ce qu’est la laisse de mer ? Partez observer le bord de mer à la plage des Roquilles à Carnon, et découvrez les traces de vie cachées sous nos yeux.
                
                L’objectif de cette animation : parcourir le littoral pour découvrir les espèces dites introduites, celles qui ont été déplacées par l’homme hors de leur région d’origine, dans le cadre du programme de sciences participatives BioLit,  animé par le CPIE Bassin de Thau.

                Ailerons vous accompagnera pour observer et participer à la science grâce au programme Biolit ce samedi 09 septembre.

                Rendez-vous à 08h00 devant la plage des Roquilles à Carnon.

                Ouvert à tous, dès 4 ans.

                Durée estimée 2h00

                Pour vous inscrire, veuillez renseigner vos informations après ce lien : ici

                Vous aussi, agissez à votre échelle pour la préservation du milieu marin !
""", image: "biolit-9-sept"
               ),
        Article(title: "Échantillonnage dans les poissonneries – Projet Mislabeling", author: "Equipe Ailerons", date: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, categories: [.unknown], description: "La campagne d’échantillonnage en poissonneries de 2023 sur la façade méditerranéenne a été commencée par les membres d’Ailerons. Elle concerne la viande de requin et les ailes de raie.", text: """
Après vous avoir expliqué comment cela se passe, on vous donnera les résultats des échantillonnages des années 2021 et 2022.

Késako l’échantillonnage ? Il suffit tout simplement de passer dans une poissonnerie, demander un échantillon du requin ou de la raie sur l’étal s’il est impossible de reconnaître l’espèce à partir de la pièce proposée à la vente. Ces échantillons sont placés dans un flacon avec de l’alcool pour ensuite les envoyer à une université qui réalise des tests ADN.

Pourquoi ? Pour identifier quelles espèces de requins et de raies sont vendues et sous quel étiquetage. Si les requins et raies vendues sont mal étiquetés (le Mislabeling), nous pouvons retourner dans les poissonneries pour prévenir, notamment s’il y a une menace d’extinction de cette espèce.

Savez-vous ce qu’est la saumonette ? La saumonette n’est pas un petit saumon, elle est un nom pour vendre plusieurs espèces de requins :

Des roussettes (grande ou petite dont la grande est quasi menacée)
Des émissoles (tachetées ou lisses, qui peuvent être appelées aussi « chien de mer », vulnérables à l’extinction)
Des aiguillats communs (qui sont en danger d’extinction)
Des requin-hâ (vulnérable à l’extinction)…
 

En 2021, trois échantillons analysés ont été mal étiquetés :

Un échantillon étiqueté en tant que “saumonette” Squalus acanthias (Aiguillat commun) a été identifié comme Mustelus asterias (Emissole tachetée)
Un autre échantillon étiqueté en tant que “saumonette” Scyliorhinus canicula (Petite roussette) a été également identifié comme Mustelus asterias (Emissole tachetée)
Dans un autre endroit, toujours un échantillon étiqueté en tant que “saumonette” Scyliorhinus canicula (Petite roussette) a encore été identifié comme Mustelus asterias (Emissole tachetée)
En 2022, 11 analyses ADN ont été réalisées sur 22 échantillons envoyés. Sur les 11 analyses, 3 ont donné un résultat d’espèce de requin différente de ce qu’il y avait écrit sur l’étiquette :

Centrophorus granulosus (Requin chagrin) -> Galeorhinus galeus (Requin-hâ)
Centrophorus granulosus (Requin chagrin) -> Mustelus asterias (Emissole tâchetée)
Deux fois dans la même poissonnerie, le même nom a été donné (Requin chagrin) et deux espèces différentes ont été trouvées.

Mustelus mustelus (Emissole lisse) -> Mustelus asterias, manazo, stevensi (Emissole tâchetée, étoilée ou requin gommeux à points blancs)
 

La campagne a commencé cette année 2023 avec déjà 14 échantillons récoltés et Ailerons vous tient au courant pour la suite…

Toutes ces espèces sont menacées d’extinction mais pas protégées, il est donc légal de les vendre… Mais avons-nous vraiment envie de manger du requin et de la raie menacées d’extinction ?
""", image: "qcdchezpatrice202104021"
               )
    ].sorted(by: { $0.date > $1.date })
    
    var filteredArticles: [Article] {
            if let selectedCategory = selectedCategory {
                return articles.filter { $0.categories.contains(selectedCategory) }
            } else {
                return articles // Affiche tous les articles si "Tout" est sélectionné
            }
        }
    
    var body: some View {
        NavigationStack {
            VStack{
                
                Picker("Catégories", selection: $selectedCategory) {
                    Text("Tout").tag(Category?.none)
                    ForEach(categories, id: \.self) { category in
                        Text(category?.rawValue.capitalized ?? "Tout").tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(Array(filteredArticles.enumerated()), id: \.offset) { index, article in
                            NavigationLink(destination: ArticleView(article: article)) {
                                
                                ZStack(alignment: .bottomLeading) {
                                    Image(article.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width - 20, height: getHeightForIndex(index))
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .shadow(radius: 5)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(article.title)
                                            .font(.system(size: getTitleFontSizeForIndex(index), weight: .bold))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                            .minimumScaleFactor(0.8)
                                        
                                        Text("\(article.author)  \(article.date.ISO8601Format())")
                                            .font(.system(size: getSubtitleFontSizeForIndex(index)))
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width - 20, alignment: .bottomLeading)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.8), .clear]), startPoint: .bottom, endPoint: .top)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Actualités")
        }
    }
    
    func getHeightForIndex(_ index: Int) -> CGFloat {
        switch index {
        case 0:
            return 220
        case 1:
            return 150
        default:
            return 100
        }
    }
    
    func getTitleFontSizeForIndex(_ index: Int) -> CGFloat {
        switch index {
        case 0:
            return 22
        case 1:
            return 18
        default:
            return 14
        }
    }
    
    func getSubtitleFontSizeForIndex(_ index: Int) -> CGFloat {
        switch index {
        case 0:
            return 14
        case 1:
            return 12
        default:
            return 10
        }
    }
}


struct Article: Identifiable {
    var id: UUID = UUID()
    var title: String
    var author: String
    var date: Date
    var categories: [Category?]
    var description: String
    var text: String
    var image: String
}

enum Category: String {
    case unknown = "unknown"
    case event = "event"
}

#Preview {
    NewsView()
}
