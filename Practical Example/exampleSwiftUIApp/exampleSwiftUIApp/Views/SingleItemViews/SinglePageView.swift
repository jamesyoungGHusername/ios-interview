//
//  SingleArticleView.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import SwiftUI

struct SinglePageView: View {
    var name:String
    var artworkURL:URL?
    var contributorString:String
    var description:String
    var type:String
    init(name:String,artworkURLString:String,contrubutorString:String,description:String,type:String){
        self.name=name
        self.artworkURL=URL(string: artworkURLString)
        self.contributorString=contrubutorString
        self.description=description
        self.type=type
    }
    //Constructs a view to display content from either a video or an article.
    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 2.0){
                AsyncImage(url: artworkURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 300)
                Text(name)
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .bold()
                Text(description)
                Text(type)
            }
        }
    }
}

