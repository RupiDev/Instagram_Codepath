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
    @IBOutlet weak var intensity: UISlider!
    
    var a: Int! 
    
    var context: CIContext!
    var currentFilter: CIFilter!
    //var userInfo: UserMedia?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.photesButton.addGestureRecognizer(lpgr)
        
        context = CIContext(options: nil)
        currentFilter = CIFilter(name: "CISepiaTone")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func choosePhotos(sender: UITapGestureRecognizer)
    {
        // put code for choosing photos        
        choosingPhotes();
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?)
    {
        if event?.subtype == UIEventSubtype.MotionShake
        {
            choosingPhotes();
        }
    }
    
    func choosingPhotes()
    {
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
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let size = CGSizeMake(500, 500);
        picture.image = self.resize(editedImage, newSize: size)
        
        
        //picture.image = editedImage
        
        photesButton.setTitle("", forState: UIControlState.Normal)
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let beginImage = CIImage(image: picture.image!)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing();
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
    
    @IBAction func changeFilter(sender: AnyObject)
    {
        let ac = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func setFilter(action: UIAlertAction!)
    {
        currentFilter = CIFilter(name: action.title!)
        
        let beginImage = CIImage(image: picture.image!)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    
    @IBAction func savePic(sender: AnyObject)
    {
        UIImageWriteToSavedPhotosAlbum(picture.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>)
    {
        if error == nil
        {
            let ac = UIAlertController(title: "Saved!", message: "Image has been saved to photo library", preferredStyle: UIAlertControllerStyle.Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            
        }
        else
        {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
        
    }

    @IBAction func intensityChanged(sender: AnyObject)
    {
        
        applyProcessing();
    }
    
    func applyProcessing()
    {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: picture.image!.size.width / 2, y: picture.image!.size.height / 2), forKey: kCIInputCenterKey) }
        
        let cgimg = context.createCGImage(currentFilter.outputImage!, fromRect: currentFilter.outputImage!.extent)
        let processedImage = UIImage(CGImage: cgimg)
        
        picture.image = processedImage;
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
