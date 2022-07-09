//
//  githubPage.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import Foundation

//This struct describes the json file recieved from the Github API. 
struct RawGHPageInfo:Codable{
    let name:String
    let path:String
    let url:String
    let download_url:String
}
