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
    var description:String
    var type:String
    init(name:String,artworkURLString:String,description:String,type:String){
        self.name=name
        self.artworkURL=URL(string: artworkURLString)
        self.description=description
        self.type=type
    }
    var body: some View {
        Text(name)
        Text(description)
        Text(type)
    }
}

