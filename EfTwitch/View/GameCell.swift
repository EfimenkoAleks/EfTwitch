//
//  GameCell.swift
//  EfTwitch
//
//  Created by mac on 23.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    
    func configureCell(_ game: Game) {
        if game.gameImage != nil {
            gameImageView.image = game.gameImage
        }
    }
    
}
