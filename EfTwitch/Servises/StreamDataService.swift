//
//  StreamDataService.swift
//  EfTwitch
//
//  Created by mac on 25.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import Alamofire

class StreamDataService {
    static let instance = StreamDataService()
    
    var streams = [Stream]()
    
    func downloadStreamsForGame(_ game: Game, completed: @escaping DownloadComplete) {
        
        var viewerCountDouble: Double!
        var imageUrlString, nameString, titleString : String!
        
        //Get /streams
        let gameString = game.gameName.replacingOccurrences(of: " ", with: "+")
        let url = TWITCH_URL_STREAMS_BASE + gameString + TWITCH_URL_STREAMS_CLIENT_ID
        
        request(url).responseJSON { (response) in
            if let JSON = response.value as? [String: Any] {
                if let streamsArray = JSON["streams"] as? [Dictionary<String, Any>], streamsArray.count > 0 {
                    for i in 0..<streamsArray.count {
                        if let viewerCount = streamsArray[i]["viewers"] as? Double {
                            viewerCountDouble = viewerCount
                        }
                        if let imageDict = streamsArray[i]["preview"] as? [String : Any] {
                            if let imageUrl = imageDict["large"] as? String {
                                imageUrlString = imageUrl
                            }
                        }
                        if let channelDict = streamsArray[i]["channel"] as? [String : Any] {
                            if let name = channelDict["display_name"] as? String {
                                nameString = name
                            }
                            if let title = channelDict["status"] as? String {
                                titleString = title
                            }
                        }
                        let stream = Stream()
                        self.streams.append(stream)
                    }
                }
            }
            completed()
        }
    }
}
