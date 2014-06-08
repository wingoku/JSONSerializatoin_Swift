//
//  ViewController.swift
//  DownloadInternetData
//
//  Created by Umer Farooq on 6/8/14.
//  Copyright (c) 2014 Umer Farooq. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DownloadDataInterface {
    
    var dData : DownloadData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
          dData = DownloadData(delegate: self);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func sendData(serializedJson: NSArray)
    {
        println("Interface function VIEW_CONTROLLER\n");
    }
    
    
    @IBAction func buttonClicked()
    {
        println("Button clicked\n");
        
        
        dData?.startDownload();
    }
}

