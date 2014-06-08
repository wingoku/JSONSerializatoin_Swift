//
//  DownloadData.swift
//  DownloadInternetData
//
//  Created by Umer Farooq on 6/8/14.
//  Copyright (c) 2014 Umer Farooq. All rights reserved.
//

import UIKit


protocol DownloadDataInterface
{
    func sendData(NSArray);
}

class DownloadData: NSObject, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
   
    var ddDelegate : DownloadDataInterface?;
    
    var nsMutData : NSData = NSData();
    
    
    
    init(delegate : DownloadDataInterface?)
    {
        ddDelegate = delegate;
        
        if delegate != nil
        {
            println("delegate not nil\n");
        }
        
        if ddDelegate != nil
        {
            println("ddSelegate not nil\n");
        }
        
        //var dict : NSDictionary = NSDictionary()
        
        //ddDelegate?.sendData(dict)
        
        println("init() download data\n");
    }
    
    
    
    func startDownload()
    {
        var link : String = ""
        var encodedLink : String = link.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding);
        
        var nsUrl : NSURL = NSURL(string: encodedLink);
        
        var requestedLink : NSURLRequest = NSURLRequest(URL: nsUrl);
        
        var connection : NSURLConnection = NSURLConnection(request: requestedLink, delegate: self, startImmediately: false);
        
        connection.start();
        
        
        println("Download started\n");
    }
    
    
    // nSURLConnectionDelegate method
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!)
    {
        println("Error in Connection\n\(error.description)\n");
    }
    
    
    // NSURLConnectionDataDelegate method
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!)
    {
        println("Response recieved\n");
        
        nsMutData = NSData();
    }

    
     // NSURLConnectionDataDelegate method
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
    {
        println("Got Data\n");
        
        if nsMutData != nil
        {
            nsMutData = data as NSMutableData;
        }
        
       
        
    }
    
    // NSURLConnectionDataDelegate method
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        println("Connection Finished Loading\n");
     
        completed();
    }
    
    
    func completed()
    {
     
        println("decoding -> String\n");
        var temp : NSString = NSString(data: nsMutData, encoding: NSUTF8StringEncoding);
        println(temp);
        
     
        println("finding pos\n");
        
        var endPos = temp.rangeOfString("<!--");
        
        
        println("substring\n");
        var errorFreeString : NSString = temp.substringToIndex(endPos.location);
        
        println("\n\n\n\n\n\n\n\n\(errorFreeString)")
        
        
        println("string -> mut\n");
        nsMutData = errorFreeString.dataUsingEncoding(NSUTF8StringEncoding);
        
        
        println("done!\n");

        if !self.ddDelegate
        {
            println("Delegate is null\n");
        }
        
        if nsMutData != nil
        {
            var err : NSError?
            println("ns data no nill\n");
            // serializing json
            
            
            // causing EXC_BAD_INSTRUCTION cod= EXC_1386_INVOP
            let sJson : NSArray = NSJSONSerialization.JSONObjectWithData(nsMutData, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            
           // var dict: NSDictionary = NSDictionary();
            
            ddDelegate?.sendData(sJson)
        }

    }
    
}
