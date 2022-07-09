//
//  VideoListView.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import SwiftUI

//View responsible for displaying list of loaded videos
struct VideoListView: View {
    
    let videosURL:URL=URL(string: "https://api.github.com/repos/jamesyoungGHusername/ios-interview/contents/Practical%20Example/videos.json")!
    let dateFormatter=ISO8601DateFormatter()
    
    //Date formatter must be set up to include fractional seconds. There might be a bug with the swift JSON date-decoding strategy. Sorted in-line to avoid using jsonDecoder.dateDecodingStrategy = .iso8601 when decoding
    init(){
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
    }
    
    @StateObject var videos=ArticlesNVideosList()
    
    //displays list of loaded content by title and sorted by date.
    var body: some View {

            List(videos.videosList.data.sorted(by:
                {dateFormatter.date(from: $0.attributes.released_at)!.timeIntervalSince1970<dateFormatter.date(from:$1.attributes.released_at)!.timeIntervalSince1970}
                                                    )){video in
                NavigationLink{
                    SinglePageView(name: video.attributes.name, artworkURLString: video.attributes.card_artwork_url,contrubutorString: video.attributes.contributor_string, description: video.attributes.description, type: "Video")
                } label: {
                    Text(video.attributes.name)
                }
            }
            .onAppear(){
                Task{
                    await self.videos.reloadVideoContent(from: videosURL)
                }
            }
            .refreshable {
                Task{
                    await self.videos.reloadVideoContent(from: videosURL)
                }
            }
        
    }
    
    
}

