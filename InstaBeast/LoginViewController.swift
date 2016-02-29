//
//  ViewController.swift
//  InstaBeast
//
//  Created by Rupin Bhalla on 2/23/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController
{
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(sender: AnyObject)
    {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil
            {
                print("you are logged in")
                
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            
        }
    }

    @IBAction func signUp(sender: AnyObject)
    {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackgroundWithBlock { (sucess: Bool, error: NSError?) -> Void in
            
            if(sucess)
            {
                print("Created a user")
                self.performSegueWithIdentifier("loginSegue", sender: nil)

            }
            else
            {
                print(error?.localizedDescription)
                if(error?.code == 202)
                {
                    print("User name is taken")
                }
            }
            
        }
    }
    
    @IBAction func onEdit(sender: AnyObject)
    {
        self.view.endEditing(true)
    }
    
}

