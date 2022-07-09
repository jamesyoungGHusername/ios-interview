//
//  JsonAPIResourceStruct.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import Foundation

class RWArticleInfo:Codable{
    var data:[JsonAPIResourceStruct]
    init?(from:[JsonAPIResourceStruct]){
        data=from
    }
    init(){
        data=[]
    }
}

//Defines a Struct that conforms to the JSON:API standards. Must include type and ID at minimum, and in this case includes attributes and links.
struct JsonAPIResourceStruct:Identifiable,Codable {
    
    
    let type:String
    let id:String
    let attributes:JsonAPIAttributesStruct
    let links:[String:String]
    

}
//Defines a use-case specific struct for the JSON:API attributes used by the Ray Wenderlich website. Would need to be rewritten to conform generally to JSON:API specifications since "attributes" could contain any number of things.
struct JsonAPIAttributesStruct:Codable{
    let uri:String
    let name:String
    let description:String
    let released_at:String
    let content_type:String
    let contributor_string:String
    let card_artwork_url:String
}

