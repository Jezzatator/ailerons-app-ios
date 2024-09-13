//
//  AileronsAboutHome.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 29/03/2024.
//

import SwiftUI

struct AileronsAboutHome: View {
    var body: some View {
        VStack {
            Text("AILERONS est une association de loi 1901 à vocation scientifique et à but non lucratif créée en mai 2006 à Montpellier (Hérault, France). C’est par l’action collective de scientifiques bénévoles, d’étudiants, de volontaires de tout horizon et avec l’aide de l’ensemble des usagers de la mer (pêcheurs, gestionnaires, associations etc.) que AILERONS mène à bien ses projets.  Ses objectifs principaux sont à ce jour l’étude et la conservation des requins et des raies de Méditerranée.")
                .padding()
            Text("""
L’association AILERONS œuvre pour l’amélioration des connaissances et la protection des raies et des requins de Méditerranée. La méconnaissance actuelle et la mauvaise image de ces espèces fait cruellement défaut à la mise en place de mesures ou plans de gestion concrets. Or les populations de requins et de raies méditerranéennes n’ont jamais été aussi menacées!
                 
                 Constituée d’une équipe pluridisciplinaire de passionnés, d’étudiants et de scientifiques, AILERONS mènent de front, bénévolement, différents projets scientifiques, pédagogiques et de sciences participatives.

                 Conférences, stands, interventions dans les écoles, vulgarisation, sorties en mer, l’association AILERONS propose des activités variées tout au long de l’année où chacun peut participer de la manière qui lui convient.

                 L’association Ailerons est ouverte à tous et à toutes. Étudiants, enseignants, biologistes marins, plongeurs, pêcheurs, navigateurs…, les membres d’Ailerons sont surtout des passionnés des océans et de ses habitants qui cherchent à agir concrètement à leur échelle.
""")
            .padding()
        }
        .scrollDisabled(false)
    }
}

#Preview {
    AileronsAboutHome()
}
