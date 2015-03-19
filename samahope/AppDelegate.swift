//
//  AppDelegate.swift
//  samahope
//
//  Created by Isaac Ho on 3/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        

        Parse.setApplicationId("Oz5dstQ42Z3UQoau7JdbIZaS1PJLo3JyDaOU8cMd",
            clientKey: "VZpD5J8u6azzxkvHTGbhNe2uJpusto5aHzPobNiF")
        PFUser.enableAutomaticUser()
        
        var defaultACL = PFACL()
        // If you would like all objects to be private by default, remove this line.
        defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
        var events = ParseClient.loadEventsInForeground()
        
        
        
        let mvc = self.storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as MenuViewController
        
        let ps = UIStoryboard(name: "ProgramStoryboard", bundle: nil)
        let pvc = ps.instantiateViewControllerWithIdentifier("ProgramViewController") as ProgramViewController
        
        let ds = UIStoryboard(name: "Isaac", bundle: nil)
        let dvc = ds.instantiateViewControllerWithIdentifier("DoctorTableViewController") as DoctorTableViewController
        dvc.events = events
 
        
        mvc.viewControllers = [pvc, dvc]
        
        if let window = self.window{
            window.rootViewController = mvc
        }
        
//        ParseClient.setupParse()
        
        
//

//
//        let storyboard = UIStoryboard(name: "ProgramStoryboard", bundle: nil)
//        let programViewController = storyboard.instantiateViewControllerWithIdentifier("ProgramViewController") as ProgramViewController
//        programViewController.events = events
//        window?.rootViewController = programViewController
        

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

