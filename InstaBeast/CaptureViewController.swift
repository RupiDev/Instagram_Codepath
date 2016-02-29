//
//  CaptureViewController.swift
//  InstaBeast
//
//  Created by Rupin Bhalla on 2/24/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate {

    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var photesButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    //var userInfo: UserMedia?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.photesButton.addGestureRecognizer(lpgr)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func choosePhotos(sender: UITapGestureRecognizer)
    {
        // put code for choosing photos
        print("choosing photos")
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer)
    {
        if gestureReconizer.state != UIGestureRecognizerState.Ended
        {
            
            return
        }
        else
        {
            // put code for the  here
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(vc, animated: true, completion: nil)
            
            
            
        }
        
        
    }

    func resize(image: UIImage, newSize: CGSize) -> UIImage
    {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        //let size = CGSizeMake(50, 50);
        //picture.image = self.resize(editedImage, newSize: size)
        
        
        picture.image = editedImage
        
        photesButton.setTitle("", forState: UIControlState.Normal)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        captionTextField.resignFirstResponder()
        return true;
    }
    
    
    @IBAction func submitPost(sender: AnyObject)
    {
        
        
        //UserMedia.postUserImage(picture.image, withCaption: captionTextField.text, withCompletion: nil)
        UserMedia.postUserImage(picture.image!, withCaption: captionTextField.text) { (success: Bool, error: NSError?) -> Void in
            if(success)
            {
                print("This actually submitted the post");
                
                
                
            }
            else
            {
                print("This fails the submitted post");
                print(error?.localizedDescription);
            }
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "submitToHome")
        {
            UserMedia.postUserImage(picture.image!, withCaption: captionTextField.text) { (success: Bool, error: NSError?) -> Void in
                if(success)
                {
                    print("This actually submitted the post");
                    
                    
                }
                else
                {
                    print("This fails the submitted post");
                    print(error?.localizedDescription);
                }
            }

        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
    

}
