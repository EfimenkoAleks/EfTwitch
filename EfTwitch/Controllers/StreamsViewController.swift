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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StreamDataService.instance.downloadStreamsForGame(game) {
            for stream in StreamDataService.instance.streams {
                stream.downloadStreamImage {
                    self.streamsTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        StreamDataService.instance.removeAllStreams()
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return StreamDataService.instance.streams.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = streamsTableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as? StreamCell {
            
            let stream = StreamDataService.instance.streams[indexPath.row]
            cell.configureCell(stream)
            
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
        let stream = StreamDataService.instance.streams[indexPath.row]
        
        openStream(stream)
    }
    
    //Handler function to open stream in chosen app
    func openStream(_ stream: Stream) {
        let alert = UIAlertController(title: "Open stream in EfTwitch or in official Twitch app?", message: "Official Twitch app must be installed for latter option", preferredStyle: .alert)
        
        let openInVirerTwitchAction = UIAlertAction(title: "EfTwitch", style: .default) { (action) in
            self.performSegue(withIdentifier: "channelShowVC", sender: stream)
        }
        let openInTwitchAppAction = UIAlertAction(title: "Twitch", style: .default) { (action) in
            self.openStreamInTwitchApp(stream)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(openInVirerTwitchAction)
        alert.addAction(openInTwitchAppAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
   
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "channelShowVC" {
            if let channelVC = segue.destination as? ChannelViewController {
                if let stream = sender as? Stream {
                    channelVC.stream = stream
                }
            }
        }
    }
    
    //MARK: Mobile Deep Link
    func openStreamInTwitchApp(_ stream: Stream) {
        let streamString = TWITCH_URL_STREAM_DEEP_LINK + stream.broadcasterName
        
        if let streamUrl = URL(string: streamString) {
            if UIApplication.shared.canOpenURL(streamUrl) {
                UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
            }
        }
        
    }

}
