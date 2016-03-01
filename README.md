# Project 6 - *Instabeast*

**Instabeast** is a photo sharing app using Parse as its backend.

Time spent: **18** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"

The following **optional** features are implemented:

- [ ] Show the username and creation time for each post
- [X] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse.
- [ ] User Profiles:
   - [ ] Allow the logged in user to add a profile photo
   - [ ] Display the profile photo with each post
   - [ ] Tapping on a post's username or profile photo goes to that user's profile page

The following **additional** features are implemented:

- [X] LongPress vs Tap Gesture Recognizer
  - [X] User has to hold for the camera, but only tap to choose photos
  - [X] UITapgGestureRecognizers
- [X] Implemented Tab View Controller
- [X] Picture loads right after you submit the post
- [X] Autolayout and GUI
- [X] Added so users can add constraints to thier searches
  - [X] User can choose ascending order or descending order
  - [X] User can choose the limit of posts he/she wants to see
- [X] Implemented Motion Shake
  - [X] On the capture section, user can shake phone and camera will pop up
- [X] Implemented different types of image filtering. Gave the option of many filters
  - [X] CIBumpDistortion Filtering
  - [X] CIGaussianBlur Filtering
  - [X] CIPixellate Filtering
  - [X] CISepiaTone Filtering
  - [X] CITwirlDistortion Filtering
  - [X] CIVignette Filtering
- [X] Implemented Alert Controllers so the user can choose the many filtering options
- [X] Implemnted Slider that allows the user to control the amount of filtering for the image
- [X] Implemened action where user can save the image taken to their own photo library
  - [X] Used Alert Controllers 
  


Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I would like to discuss talking about Parse. How to retrieve and store information in Parse
2. Also I would like to talk about the table sections with the class. 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

Link to the GIF:

http://i.giphy.com/3o7abzKV6UTIVQl8Vq.gif

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Working with UITapGestureRecognizer was fun and interesting.
Learned how to implement constraints and difference between holding and tapping.
Learned how to implement photo filtering and saving images to photo libary.

Also the simulator was being really slow and wasn't loading up the pictures, so I took a video, and
converted that to a GIF and put it here

Also forgot to log out in the GIF, but I have implemented the log out feature. Check the code for that. 


Describe any challenges encountered while building the app.

The Tap Gesture Recognizer was hard to deal with. Also getting the constraints so that user can choose his/her own constraints.
Also getting data from Parse was a little confusing at first, but after a while it was easy to pick up. 

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
