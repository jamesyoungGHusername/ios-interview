//
//  ArticleListView.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import SwiftUI

//view responsible for displaying list of loaded articles
struct ArticleListView: View {
    
    
    let articlesURL:URL=URL(string: "https://api.github.com/repos/jamesyoungGHusername/ios-interview/contents/Practical%20Example/articles.json")!
    @StateObject var articles=ArticlesNVideosList()
    let dateFormatter=ISO8601DateFormatter()
    
    //Date formatter must be set up to include fractional seconds. There might be a bug with the swift JSON date-decoding strategy. Sorted in-line to avoid using jsonDecoder.dateDecodingStrategy = .iso8601 when decoding
    init(){
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
    }

    //displays list of loaded content by title and sorted by date.
    var body: some View {
            List(articles.articlesList.data.sorted(by:
                    {dateFormatter.date(from: $0.attributes.released_at)!.timeIntervalSince1970<dateFormatter.date(from:$1.attributes.released_at)!.timeIntervalSince1970}
                                                  )){article in
                NavigationLink{
                    SinglePageView(name: article.attributes.name, artworkURLString: article.attributes.card_artwork_url,contrubutorString: article.attributes.contributor_string, description: article.attributes.description, type: "Article")
                } label: {
                    Text(article.attributes.name)
                }
            }
            .onAppear(){
                Task{
                    await self.articles.reloadArticleContent(from: articlesURL)
                }
            }
            .refreshable {
                Task{
                    await self.articles.reloadArticleContent(from: articlesURL)
                }
            }
        
        }
}

