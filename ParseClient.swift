//
//  ParseClient.swift
//  samahope
//
//  Created by Isaac Ho on 3/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class ParseClient {
    class var sharedInstance: ParseClient {
        struct Singleton {
            static var instance: ParseClient?
        }
        if ( Singleton.instance == nil ) {
            Singleton.instance = ParseClient()
            Singleton.instance!.loadEventsInForeground()
        }
        return Singleton.instance!
    }
    
    var events: [ Event ]?
    var projects: [ Project ]? // needed because not all projects are associated with all events
    
    class func setupParse() {
        // Parse.enableLocalDatastore()
        Parse.setApplicationId("Oz5dstQ42Z3UQoau7JdbIZaS1PJLo3JyDaOU8cMd",
            clientKey: "VZpD5J8u6azzxkvHTGbhNe2uJpusto5aHzPobNiF")
        PFUser.enableAutomaticUser()
        // If you would like all objects to be private by default, remove this line.
        var defaultACL = PFACL()
        defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
        
    }

    
    // loadLatestTransactions() // return the last x transcations

    // updates the associated project/event records in db
    func processPayment( amount: Int, project: Project, event: Event ) {
        var tx = Transaction()
        tx.setValues( amount, project: project, event: event )
        
        
        var newNeeded = ( project.amountNeeded!.integerValue + amount ) %
            project.totalAmount!.integerValue
        project.amountNeeded = ( newNeeded )
        event.totalDonations = (amount + event.totalDonations!.integerValue)
        var errorPtr = NSErrorPointer()

        println( "saving event" )
        if ( event.save( errorPtr )) {
            println( "event saved" )
        }
        else {
            println("event not saved with error: \(errorPtr)" )
        }

        if ( project.save( errorPtr) ) {
            println( "project saved")
        } else {
            println( "project not saved with error: \(errorPtr)")
        }

        println( "tx: objectId = \(tx.objectId)" )
        if ( tx.save( errorPtr ) ) {
            println( "tx saved with objectId \(tx.objectId)" )
        } else {
            println( "error: \(errorPtr)" )
        }
     
    }
    
    func printTime() {
        println( NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle))
    }
    

    // gives you back an array of Transaction objects, sorted by descending timestamp
    // runs in the background, then calls your callback upon completion ( no error state is kept, so
    //    caveat emptor! hopefully the array it sends you will be nil... )
    func loadTransactions( numRowsToReturn: Int, callback: ( [Transaction] ) -> () ) {
        var returnVal = true
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //Background Thread
            var query = Transaction.query()
            query.includeKey("project")
            query.includeKey("event")
            query.limit = numRowsToReturn
            query.orderByDescending("createdAt")
            var errorPtr = NSErrorPointer()
            var txObjects = query.findObjects(errorPtr)
            var tx = txObjects[0]
            
            callback( txObjects as [Transaction] )
        }

    }
    // loads events and associated objects in background with a callback
    func loadEvents( callback: ( Bool ) -> () ) {
        var returnVal = true
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            //Background Thread
            returnVal = self.loadEventsInForeground()
            callback( returnVal )
        }
    }
    // fires off loadEvents in a background thread
    // currently takes less than .5 seconds to run
    // actually loads all events, all projects: note some projects may not be related to any events
    func loadEventsInForeground() -> Bool {
        var query = Event.query()
        var errorPtr = NSErrorPointer()
        var myEvents = [Event]()

    
        printTime()
        var eventObjects = query.findObjects( errorPtr )
        println( "\(eventObjects.count) objects loaded with error: \(errorPtr)" )
        
        query = Project.query()
        var projectObjects = query.findObjects( errorPtr )
        println( "\(projectObjects.count) objects loaded with error: \(errorPtr)" )
        
        projects = projectObjects as? [Project]
        if let events = eventObjects as? [Event] {
            for event in events {
                var projectPointers = event["projects"] as [PFObject]
                
                
                event.projects = [Project]()
                for projectPointer in projectPointers {
                    for p in projects! {
                        if projectPointer.objectId == p.objectId {
                            event.projects.append( p )
                            println("appending project")
                        }
                    }
                }
                myEvents.append( event )
            }
        }
        events = myEvents
        return true
    }
    func loadEventsInForegroundDefunct() {
        var query = Event.query()
        var myEvents = [Event]()
        var errorPtr = NSErrorPointer()
        
        var objects = query.findObjects( errorPtr )
        println( "\(objects.count) objects loaded with error: \(errorPtr)" )
        
        // Do something with the found objects
        if let events = objects as? [Event] {
            for event in events {
                var projectPointers = event["projects"] as [PFObject]
                event.projects = [Project]()
                for projectPointer in projectPointers {
                    var projectQuery = Project.query()
                    var projectResponse = projectQuery.getObjectWithId(projectPointer.objectId)
                    
                    if let project = projectResponse as? Project {
                        
                        println(project.doctorImage!)
                        event.projects.append(project)
                    } else {
                        println("That was not a project :(!")
                    }
                }
                myEvents.append( event )
            }
        }
        events = myEvents
    }
    
    class func loadEventsDefunct() -> [Event] {
        var events = [Event]()
        var query = Event.query()
        
        var errorPtr = NSErrorPointer()
        
        query.findObjectsInBackgroundWithBlock {
           (objects: [AnyObject]!, error: NSError!) -> Void in
            if errorPtr == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) objects.")
                
                // Do something with the found objects
                if let events = objects as? [Event] {
                    for event in events {
                        var projectPointers = event["projects"] as [PFObject]
                        event.projects = [Project]()
                        for projectPointer in projectPointers {
                            var projectQuery = Project.query()
                            var projectResponse = projectQuery.getObjectWithId(projectPointer.objectId)
                            
                            if let project = projectResponse as? Project {
                                
                                println(project.doctorImage!)
                                event.projects.append(project)
                            } else {
                                println("That was not a project :(!")
                            }
                        }
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
        return events
    }
    
    class func buildTestDb() {
        var p = Project()
        p.doctorBio = "Save all the arms in the world z"
        p.doctorName = "Dr. Seymour Butts"
        
        var e = Event()
        e.name = "Donate-a-thon"
        
        e.projects.append( p )
        
        if ( e.save() ) { println( "save succeeded" ) }
        else
        {
            println( "save failed" )
        }
    }
    
    // just for sanity--retrieves all the doctor records
    class func testQuery() {
        var query = PFQuery(className:"Doctor")
//        query.whereKey("playerName", equalTo:"Sean Plott")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) objects.")
                
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
    }
}