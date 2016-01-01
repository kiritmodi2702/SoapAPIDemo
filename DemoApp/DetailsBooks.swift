//
//  DetailsBooks.swift
//  DemoApp
//
//  Created by Nimble Chapps on 01/01/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit

class DetailsBooks: UITableViewController {
    
    var dictAll = NSDictionary()
    
    var arrayBooks = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dictAll)
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        arrayBooks = dictAll.objectForKey("BibleBookChapterVerse") as! NSMutableArray

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBooks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIDN", forIndexPath: indexPath)

        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
       cell.textLabel?.text = arrayBooks.objectAtIndex(indexPath.row).objectForKey("Text")!.objectForKey("text") as? String

        return cell
    }

}
