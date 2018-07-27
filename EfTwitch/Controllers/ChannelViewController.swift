//
//  ChannelViewController.swift
//  EfTwitch
//
//  Created by mac on 27.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import WebKit

class ChannelViewController: UIViewController {
    
    var stream: Stream!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        
        let urlString = TWITCH_URL_EMBED_BASE + stream.broadcasterName + TWITCH_URL_EMBED
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    
    


}
