//
//  StreamsViewController.swift
//  EfTwitch
//
//  Created by mac on 25.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class StreamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var streamsTableView: UITableView!
    
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "\(game.gameName!)"
        
        streamsTableView.delegate = self
        streamsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = streamsTableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as? StreamCell {
            return cell
        } else {
            return StreamCell()
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (streamsTableView.bounds.width / 16) * 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TOODOO
    }

}
