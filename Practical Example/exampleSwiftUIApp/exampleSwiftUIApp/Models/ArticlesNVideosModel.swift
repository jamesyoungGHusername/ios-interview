//
//  ArticlesModel.swift
//  exampleSwiftUIApp
//
//  Created by James Young on 7/9/22.
//

import Foundation

//This file has code for loading and reloading content from the web.

@MainActor
class ArticlesNVideosList:ObservableObject{
    @Published public var articlesList:RWArticleInfo=RWArticleInfo()
    @Published public var videosList:RWArticleInfo=RWArticleInfo()
    @Published public var allContent:RWArticleInfo=RWArticleInfo()
 
    let jsonDecoder:JSONDecoder
    init(){
        jsonDecoder=JSONDecoder()
    }
    
    //Reloads both the article and video list from the provided urls, and also updates the full content list.
    func reloadAllContent(videoURL:URL,articleURL:URL) async{
        await reloadArticleContent(from: articleURL)
        await reloadVideoContent(from: videoURL)
        let fullList:[JsonAPIResourceStruct]=videosList.data+articlesList.data
        allContent=RWArticleInfo(from: fullList)!
    
    }
    
    //Reloads only the article content from the provided URL
    func reloadArticleContent(from url:URL) async{
        let urlSession=URLSession.shared
        do{
            var (data,_)=try await urlSession.data(from: url)
        
            let contentFile:RawGHPageInfo=try! jsonDecoder.decode(RawGHPageInfo.self,from:data)
    
            let rawURL=URL(string: contentFile.download_url)!
            (data,_)=try await urlSession.data(from: rawURL)
            
            self.articlesList = try! jsonDecoder.decode(RWArticleInfo.self,from:data)
            }catch{
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
    
    //Reloads only the video content from the provided URL
    func reloadVideoContent(from url:URL) async{
        let urlSession=URLSession.shared
        do{
            var (data,_)=try await urlSession.data(from: url)
          
            let contentFile:RawGHPageInfo=try! jsonDecoder.decode(RawGHPageInfo.self,from:data)
       
            let rawURL=URL(string: contentFile.download_url)!
            (data,_)=try await urlSession.data(from: rawURL)
            
            self.videosList = try! jsonDecoder.decode(RWArticleInfo.self,from:data)

        }catch{
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
    
   
}

