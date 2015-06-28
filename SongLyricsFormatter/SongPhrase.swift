//
//  SongPhrase.swift
//  SongLyricsFormatter
//
//  Created by Federico Jordán on 23/6/15.
//  Copyright (c) 2015 Federico Jordán. All rights reserved.
//

import Cocoa

class SongPhrase {
    var songId: String
    var content: String
    var startTime: Int
    var endTime: Int
    
    init(){
        songId = ""
        content = ""
        startTime = 0
        endTime = 0
    }
    
    init(songId: String, content: String, startTime: Int, endTime: Int){
        self.songId = songId
        self.content = content
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func show(){
        println("songId: \(songId) content: \(content) startTime: \(startTime) endTime: \(endTime))")
    }
}
