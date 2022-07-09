//
//  AllFilesListView.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import SwiftUI
struct AllFilesListView: View {
    
    let videosURL:URL
    let articlesURL:URL
    let dateFormatter=ISO8601DateFormatter()
    
    //Date formatter must be set up to include fractional seconds. There might be a bug with the swift JSON date-decoding strategy. Sorted in-line to avoid using jsonDecoder.dateDecodingStrategy = .iso8601 when decoding
    init(articlesURL:URL,videosURL:URL){
        self.videosURL=videosURL
        self.articlesURL=articlesURL
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
    }
    
    //all loaded content
    @StateObject var loadedContent:ArticlesNVideosList=ArticlesNVideosList()
    
    //displays list of loaded content by title and sorted by date.
    var body: some View {
  
            List(loadedContent.allContent.data.sorted(by:
                {dateFormatter.date(from: $0.attributes.released_at)!.timeIntervalSince1970<dateFormatter.date(from:$1.attributes.released_at)!.timeIntervalSince1970}
                                                            )){content in
                NavigationLink{
                    SinglePageView(name: content.attributes.name, artworkURLString: content.attributes.card_artwork_url,contrubutorString: content.attributes.contributor_string, description: content.attributes.description, type: content.attributes.content_type)
                } label: {
                    Text(content.attributes.name)
                }
            }
            .onAppear(){
                Task{
                    await self.loadedContent.reloadAllContent(videoURL:videosURL,articleURL:articlesURL)
                }
            }
            .refreshable {
                Task{
                    await self.loadedContent.reloadAllContent(videoURL:videosURL,articleURL:articlesURL)
                }
            }
        
    }
    
    
}

