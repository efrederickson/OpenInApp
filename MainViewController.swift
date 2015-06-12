//
//  ViewController.swift
//
//  Created by Andi Andreas on 5/16/15.
//  Copyright (c) 2015. All rights reserved.
//

import UIKit

extension String
{
    public func indexOfCharacter(char: Character) -> String.Index? {
        if let idx = find(self, char) {
            return idx
            //return distance(self.startIndex, idx)
        }
        return nil
    }
}

class SiteData : NSObject {
    var title: String?
    var expression: String?
    var replacement: String?
    
    init(title: String, expression: String, replacement: String) {
        self.title = title
        self.expression = expression
        self.replacement = replacement
    }
    
    func getSite() -> String
    {
        return self.expression!.substringToIndex(self.expression!.indexOfCharacter("/")!)
    }
    
    func getScheme() -> String
    {
        return self.replacement!.substringToIndex(self.replacement!.indexOfCharacter(":")!)
    }
}



class MainViewController: UITableViewController {
    var data = NSMutableArray.new()
    
    func loadData()
    {
        data = NSMutableArray.new()
        
        var basePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var filePath = basePath + "user_created.plist"

        var mappings = NSDictionary(contentsOfFile: filePath)
        if mappings == nil
        {
            return;
        }
    
        let userArray: NSArray = mappings?.objectForKey("user") as! NSArray
        for array in userArray
        {
            if array.count == 0
            {
                continue;
            }
            
            let siteData = SiteData(title: array[0] as! String, expression: array[1] as! String, replacement: array[2] as! String)
            data.addObject(siteData)
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        var firstColor = UIColor(red: (196/255.0), green: (86/255.0), blue: (248/255.0), alpha: 1.0)
        var secondColor = UIColor(red: (107/255.0), green: (99/255.0), blue: (231/255.0), alpha: 1.0)
        var colors: [CGColor] = [firstColor.CGColor, secondColor.CGColor]
        var navbar = self.navigationController?.navigationBar as! CRGradientNavigationBar
        navbar.setBarTintGradientColors(colors)
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("app") as! UITableViewCell
        var image: UIImageView = cell.viewWithTag(3) as! UIImageView
        image.image = UIImage(named: "Present")
        var title: UILabel = cell.viewWithTag(1) as! UILabel
        var subtitle: UILabel = cell.viewWithTag(2) as! UILabel
        if (data.count > indexPath.row)
        {
            let d = data[indexPath.row] as! SiteData
            title.text = d.title
            subtitle.text = d.getSite()
        }
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alertController = UIAlertController(title: "OpenInApp", message:
            "Expression: ", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete)
        {
            var basePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            var filePath = basePath + "user_created.plist"
            
            var mappings = NSDictionary(contentsOfFile: filePath)
            if mappings == nil
            {
                return;
            }
            
            let userArray: NSArray = mappings?.objectForKey("user") as! NSArray
            let mutableArray: NSMutableArray = userArray.mutableCopy() as! NSMutableArray
            
            mutableArray.removeObjectAtIndex(indexPath.row)
            
            let dict: NSDictionary = ["user": mutableArray] as NSDictionary
            dict.writeToFile(filePath, atomically: true)
            self.loadData()
        }
    }
}

