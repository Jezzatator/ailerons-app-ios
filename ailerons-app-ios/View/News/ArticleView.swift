//
//  ArticleView.swift
//  ailerons-app-ios
//
//  Created by Jérémie Patot on 11/09/2024.
//

import SwiftUI

struct ArticleView: View {
    var article: Article
    var body: some View {
        ScrollView {
            Text(article.title)
            Text(article.author)
            Text(article.date.ISO8601Format())
            Text(article.description)
            Text(article.text)
        }
        .padding()
    }
}

//#Preview {
//    ArticleView()
//}
