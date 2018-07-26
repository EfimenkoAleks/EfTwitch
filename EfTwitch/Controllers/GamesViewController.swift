//
//  GamesViewController.swift
//  EfTwitch
//
//  Created by mac on 23.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Games"
        
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GamesViewController.reloadData), for: UIControlEvents.valueChanged)
        gameCollectionView.insertSubview(refreshControl, at: 0)
        
        reloadData()
    }
    
    @objc func reloadData() {
        GameDataService.instance.downloadTopGames {
            for game in GameDataService.instance.games {
                game.dewnloadGameImage(completed: {
                    self.gameCollectionView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameDataService.instance.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as? GameCell {
            
            let game = GameDataService.instance.games[indexPath.row]
            cell.configureCell(game)
            
            return cell
        } else {
            return GameCell()
        }
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let game = GameDataService.instance.games[indexPath.row]
        
        performSegue(withIdentifier: "streamShowVC", sender: game)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectioView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (gameCollectionView.bounds.width / 2) - 15
        let height = width * (4 / 3)
        
        return CGSize(width: width, height: height)
        
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "streamShowVC" {
            if let streamVC = segue.destination as? StreamsViewController {
                if let game = sender as? Game {
                    streamVC.game = game
                }
            }
        }
    }
    
}
