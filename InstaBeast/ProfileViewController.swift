//
//  ProfileViewController.swift
//  InstaBeast
//
//  Created by Rupin Bhalla on 2/24/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import Parse
var choice: Int?
var postNum1: Int?
class ProfileViewController: UIViewController
{
    //var user: PFUser?

    @IBOutlet weak var postNum: UILabel!
    @IBOutlet weak var postsSlider: UISlider!
    @IBOutlet weak var queryChoiceSegment: UISegmentedControl!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // 0 = descending
        // 1 = ascending
        var array = [0, 1];
        choice = array[queryChoiceSegment.selectedSegmentIndex]
        
       postNum1 = Int(postsSlider.value)
        
       postNum.text = String(Int(postsSlider.value))
    
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(sender: AnyObject)
    {
        PFUser.logOut();
    }

    @IBAction func didChange(sender: AnyObject)
    {
        choice = queryChoiceSegment.selectedSegmentIndex
        postNum1 = Int(postsSlider.value)
        postNum.text = String(Int(postsSlider.value))
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
