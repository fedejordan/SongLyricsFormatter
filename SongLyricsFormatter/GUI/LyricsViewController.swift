//
//  LyricsViewController.swift
//  SongLyricsFormatter
//
//  Created by Federico Jordán on 22/6/15.
//  Copyright (c) 2015 Federico Jordán. All rights reserved.
//

import Cocoa

class LyricsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet var lyricsTextView: NSTextView!
    @IBOutlet var secondsTextField: NSTextField!
    @IBOutlet var phraseLimitButton: NSButton!
    @IBOutlet var startButton: NSButton!
    @IBOutlet var phrasesTableView: NSTableView!
    @IBOutlet var songIdTextField: NSTextField!
    var phrasesResults = [SongPhrase]()
    var seconds: Int = 0
    var phrases = [String]();
    var actualPhrase: String?
    var actualIndex = -1
    var counting = false
    var songId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func didSelectAnalyzeLyrics(sender: AnyObject){
        if(songIdTextField.stringValue=="" || (lyricsTextView.textStorage as NSAttributedString!).string == ""){
            println("Cannot analyze lyrics")
        }
        else{
            if(counting==false){
                startCounter()
                startButton.title = "Stop"
                songId = songIdTextField.stringValue
                songIdTextField.enabled = false
            }
            else{
                stopCounter()
                startButton.enabled = false
                phraseLimitButton.enabled = false
            }
        }
        
    }
    
    @IBAction func didSelectPhraseLimit(sender: AnyObject) {
        if phraseLimitButton.title == "Start phrase!"{
            phraseLimitButton.title = "End phrase!"
            actualIndex++
            actualPhrase = phrases[actualIndex]
            var phraseToAdd = SongPhrase(songId: "\(actualIndex)", content: actualPhrase!, startTime: seconds, endTime: 0)
            phrasesResults.append(phraseToAdd)
        }
        else{
            phraseLimitButton.title = "Start phrase!"
            actualPhrase = ""
            var phraseToAdd = phrasesResults.last
            phraseToAdd?.endTime = seconds

        }
        phrasesTableView.reloadData()
    }
    
    
    func startCounter(){
        analyzePhrases()
        phrasesTableView.reloadData()
        counting = true
        phraseLimitButton.enabled = true
        actualPhrase = ""
        updateTextView()
        countSeconds()
    }
    
    func stopCounter(){
        counting = false
        phraseLimitButton.enabled = true
        showCurrentResultsForSQL()
    }
    
    func countSeconds(){
        if counting{
            secondsTextField.stringValue = "\(seconds)"
            seconds++
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countSeconds"), userInfo: nil, repeats: false)
        }
    }
    
    func updateTextView(){
        var highlightedStringAttributes = [NSForegroundColorAttributeName: NSColor.redColor()]
        var attrString = NSMutableAttributedString()
        for phrase in phrases{
            if phrase == actualPhrase{
                attrString.appendAttributedString(NSAttributedString(string: phrase, attributes: highlightedStringAttributes))
            }
            else{
                attrString.appendAttributedString(NSAttributedString(string: phrase))
            }
        }
    }
    
    func analyzePhrases(){
        var lyrics = (lyricsTextView.textStorage as NSAttributedString!).string
        phrases = lyrics.componentsSeparatedByString("\n")
        var auxArray = [String]()
        for phrase in phrases{
            if phrase != ""{
                auxArray.append(phrase)
            }
        }
        phrases = auxArray
    }
    
    func showCurrentResults(){
        for sp in phrasesResults{
            sp.show()
        }
    }
    
    func showCurrentResultsForSQL(){
        var sqlQuery = "INSERT INTO songphrase (content, start_time, end_time, song_id) VALUES "
        for sp in phrasesResults{
            sqlQuery += "( \""
//            sqlQuery += sp.songId + ", "
            sqlQuery += sp.content + "\", "
            sqlQuery += "\(sp.startTime), "
            sqlQuery += "\(sp.endTime), "
            sqlQuery += "\(songId) ), "
        }
        sqlQuery = sqlQuery.substringToIndex(advance(sqlQuery.endIndex, -2))
        println(sqlQuery)
    }
    
}

extension LyricsViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return phrases.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // 1
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        let phrase = self.phrases[row]
        if actualIndex == row && actualPhrase != ""{
            cellView.textField?.textColor = NSColor.redColor()
        }
        else{
            cellView.textField?.textColor = NSColor.blackColor()
        }
        cellView.textField!.stringValue = phrase
        return cellView

    }
}


