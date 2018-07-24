//
//  Games.swift
//  EfTwitch
//
//  Created by mac on 24.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire

class Game {
    
    var gameName: String!
    var gameImageUrl: String!
    var gameImage: UIImage?
    
    init(name: String, imageUrl: String) {
        self.gameName = name
        self.gameImageUrl = imageUrl
    }
    
    func dewnloadGameImage(completed: @escaping DownloadComplete) {
        request(self.gameImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.gameImage = image
                }
            }
            completed()
        }
    }
    
}
