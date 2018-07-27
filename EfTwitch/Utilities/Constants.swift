//
//  Constants.swift
//  EfTwitch
//
//  Created by mac on 23.07.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation

//client_id
//c57h5de333qgpgwppblw0kizqmzdoq


//Twitch API URLs
let TWITCH_URL_TOP_GAMES = "https://api.twitch.tv/kraken/games/top?limit=50&client_id=c57h5de333qgpgwppblw0kizqmzdoq"

let TWITCH_URL_STREAMS_BASE = "https://api.twitch.tv/kraken/streams?game="
let TWITCH_URL_STREAMS_CLIENT_ID = "&client_id=c57h5de333qgpgwppblw0kizqmzdoq"
let TWITCH_URL_EMBED_BASE = "https://www.twitch.tv/"
let TWITCH_URL_EMBED = "/embed"
let TWITCH_URL_STREAM_DEEP_LINK = "twitch://open?stream="

typealias DownloadComplete = () -> ()

//https://api.twitch.tv/kraken/streams?game=Dota+2&client_id=c57h5de333qgpgwppblw0kizqmzdoq
//https://www.twitch.tv/qsnake/embed
