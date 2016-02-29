//
//  HomeViewController.swift
//  InstaBeast
//
//  Created by Rupin Bhalla on 2/24/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var allInfo: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        query();
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // construct PFQuery
        
        query()
        
    }
    
    func query()
    {
        // construct PFQuery
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media
            {
                print(media)
                print("Rohan Raval")
                self.allInfo = media
                print(self.allInfo);
                self.tableView.reloadData();
            }
            else
            {
                "Rohan Raval is the key to errors"
            }
            
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(allInfo != nil)
        {
            print(allInfo!.count)
            return allInfo!.count
        }
        else
        {
            return 0;
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! InstaCell
        
        var instaC = allInfo![indexPath.row];
        
        cell.captionLabel.text = instaC.valueForKeyPath("caption") as! String
        
        var image: UIImage?
        let profileImage = instaC.valueForKeyPath("media") as! PFFile
        do
        {
            let profile = try profileImage.getData()
            image = UIImage(data: profile)
            
        }
        catch
        {
            print("Rohan raval ")
        }
        cell.pic.image = image;
    
        
        
        return cell;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
