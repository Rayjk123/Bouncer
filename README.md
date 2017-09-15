# Bouncer

A hack for [hackGSU 2017](http://hackgsu.com) 
The hackathon lasted for a total of 36 hours so this app was built within a 36 hour timeframe. 

## Problem Space
There was a prompt at hackGSU by Anthem about how can we make it easier to securely check in guests to a building. 
The problem being that the current process was:
* guest reaches the front desk of the building on the first floor.
* Person at desk requests a person from the company to come downstairs and pick them up
* Employee takes them to their floor
* Takes them to their front desk on the floor
* Finally, verify the guest. 

Overall the process was just very lackluster and inefficient, so what could we do to make it easier for all parties but at the same time still secured.

## About Bouncer
Bouncer is a iOS mobile app built with Swift in XCode with Google Firebase as its backend. 
The App consists of 4 parts:
1. Guest sign-in/register so that they are a part of the system and receive QR Codes
2. Employee Log-in so that they can send guest's their QR Codes based on their email address
3. Security Log-in: Consists of a scanner which will verify a QR Code
* The Security Log-In is for either a Security Guard/Front Desk to scan and verify the QR Code
* Or a Security Gate that is able to Scan QR Codes so that people can just scan their QR Code from their phone and enter       the building.
4. The ability to create a GeoFence so that when a Guest exits the building they will be automatically checked out.

The App has 3 different roles for people
1. Employee
* Employees cannot sign up and should be added by the administrator through a different employee app or through the Firebase portal.
* An Employee login to test this app is
* User: anthem@gmail.com
* Password: 123456

2. Guest
* Anyone who owns the app and wants to enter the building can be a guest.
* User: 1@gmail.com
* Password: 123456

3. Security Guard/Gate
* The Security responsible for validating scanned QR Codes.
* A Guest Sign in to test this app is:

## Building

Written in Swift with XCode and [CocoaPods](https://cocoapods.org).
- Install CocoaPods
- `git clone` our repository
- Run `pod install` in the base directory
- Open `Bouncer.xcworkspace` in XCode. **Warning**: Do not open `Bouncer.xcodeproj`!
- Build and run in XCode. Tested on iOS 10.3 (Simulator).

