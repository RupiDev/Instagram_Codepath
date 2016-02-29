//
//  UserMedia.swift
//  InstaBeast
//
//  Created by Rupin Bhalla on 2/25/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import Parse

class UserMedia: NSObject
{
    /**
     Method to post user media to Parse by uploading image file
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let media = PFObject(className: "UserMedia")
        
        // Add relevant fields to the object
        media["media"] = getPFFileFromImage(image) // PFFile column type
        
        /*let profileImage = media["media"] as! PFFile
        profileImage.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
            if(error != nil)
            {
                if let imageData = imageData
                {
                    let image = UIImage(data: imageData)
                }
            }
            
        }*/
        
            
        media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        media["caption"] = caption
        media["likesCount"] = 0
        media["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        media.saveInBackgroundWithBlock(completion)
        if((completion) != nil)
        {
            print("good")
        }
        
    }
    
    /**
    Method to post user media to Parse by uploading image file
    
    - parameter image: Image that the user wants to upload to parse
    
    - returns: PFFile for the the data in the image
    */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
