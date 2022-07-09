//
//  ContentView.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let articlesURL:URL=URL(string: "https://api.github.com/repos/jamesyoungGHusername/ios-interview/contents/Practical%20Example/articles.json")!
    let videosURL:URL=URL(string: "https://api.github.com/repos/jamesyoungGHusername/ios-interview/contents/Practical%20Example/videos.json")!

    //Top level view managing navigation and tabs
    var body: some View {
        
            TabView{
                NavigationView{
                    ArticleListView()
                    .navigationTitle("Articles")
                }.tabItem{
                    Label("Articles",systemImage: "doc.text")
                }
                NavigationView{
                    VideoListView()
                    .navigationTitle("Videos")
                }.tabItem{
                    Label("Videos", systemImage: "video")
                }
                NavigationView{
                    AllFilesListView(articlesURL: articlesURL, videosURL: videosURL)
                    .navigationTitle("All Content")
                }.tabItem{
                    Label("All",systemImage: "magazine")
                }
                
            }
            //Added green accent to match ray wenderlich website
            .accentColor(.green)
       
    }
    
}


