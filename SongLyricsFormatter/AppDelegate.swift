//
//  AppDelegate.swift
//  SongLyricsFormatter
//
//  Created by Federico Jordán on 22/6/15.
//  Copyright (c) 2015 Federico Jordán. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var lyricsViewController: LyricsViewController!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        lyricsViewController = LyricsViewController(nibName: "LyricsViewController", bundle: nil)
        
        window.contentView.addSubview(lyricsViewController.view)
        lyricsViewController.view.frame = (window.contentView as! NSView).bounds
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

