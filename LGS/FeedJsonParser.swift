//
//  FeedJsonParser.swift
//  LGS
//
//  Created by Эрик Вильданов on 23.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class FeedJsonParser {
    
    var quotes = Quotes()
    
    private var parserCompletionHandler:(Quotes -> Void )?
    
    func parseFeed (jsonUrl: String, completionHandler: (Quotes -> Void)?) -> Void {
        
        self.parserCompletionHandler = completionHandler
        
        let request = NSURLRequest(URL: NSURL(string: jsonUrl)!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request, completionHandler:{
            (data, _, error) -> Void in
            
            if error != nil {
                print("\(error?.localizedDescription)")
            }
            self.parser(data!)
        })
        task.resume()
        
    }
    
    func parser(data: NSData){
        
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        
        if let total = json["total"] as? Int{
            self.quotes.total = total
        }
        
        if let last = json["last"] as? String{
            self.quotes.last = last
        }
        
        if let quotes = json["quotes"] as? [[String: AnyObject]] {
            for quotes in quotes {
                
                if let id = quotes["id"] as? Int {
                    self.quotes.id.append(id)
                }
                if let description = quotes["description"] as? String {
                    let str = self.replaceMatches("<br>", inString: description, withString: "\\n")
                    self.quotes.description.append(str!)
                }
                if let time = quotes["time"] as? String {
                    self.quotes.time.append(time)
                }
                if let rating = quotes["rating"] as? Int {
                    self.quotes.rating.append(rating)
                }
            }
        }
        
        parserCompletionHandler?(quotes)
    }
    
    
    func replaceMatches(pattern: String, inString string: String, withString replacementString: String) -> String? {
        let regex = try! NSRegularExpression(pattern: pattern, options: .AllowCommentsAndWhitespace)
        let range = NSMakeRange(0, string.characters.count)
        
        return regex.stringByReplacingMatchesInString(string, options: .ReportCompletion, range: range, withTemplate: replacementString)
    }
    
}
