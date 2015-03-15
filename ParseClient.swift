//
//  ParseClient.swift
//  samahope
//
//  Created by Isaac Ho on 3/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class ParseClient {
    class func setupParse() {
//        Parse.enableLocalDatastore()
        Parse.setApplicationId("Oz5dstQ42Z3UQoau7JdbIZaS1PJLo3JyDaOU8cMd",
            clientKey: "VZpD5J8u6azzxkvHTGbhNe2uJpusto5aHzPobNiF")
        PFUser.enableAutomaticUser()
        // If you would like all objects to be private by default, remove this line.
        var defaultACL = PFACL()
        defaultACL.setPublicReadAccess(true)
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)

    }    
    
    class func loadEventWithCallback(callback: (event: Event?) -> Void) {
        var test = PFQuery(className: "Event")
        var objs = test.findObjects()
        var query = Event.query()
                
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved an event.")
                if let event = object as? Event {
                    var projectPointers = event["projects"] as [PFObject]
                    event.projects = [Project]()
                    for projectPointer in projectPointers {
                        var projectQuery = Project.query()
                        var projectResponse = projectQuery.getObjectWithId(projectPointer.objectId)
                        
                        if let project = projectResponse as? Project {
                            event.projects.append(project)
                        } else {
                            println("That was not a project :(!")
                        }
                    }
                    callback(event: event)
                }


            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }

        }
    }
    
//    class func buildTestDb() {
//        var p = Project()
//        p.doctorBio = "Save all the arms in the world z"
//        p.doctorName = "Dr. Seymour Butts"
//        
//        var e = Event()
//        e.name = "Donate-a-thon"
//        
//        e.projects.append( p )
//        
//        if ( e.save() ) { println( "save succeeded" ) }
//        else
//        {
//            println( "save failed" )
//        }
//    }
//    
//    // just for sanity--retrieves all the doctor records
//    class func testQuery() {
//        var query = PFQuery(className:"Doctor")
////        query.whereKey("playerName", equalTo:"Sean Plott")
//        
//        query.findObjectsInBackgroundWithBlock {
//            (objects: [AnyObject]!, error: NSError!) -> Void in
//            if error == nil {
//                // The find succeeded.
//                println("Successfully retrieved \(objects.count) objects.")
//                
//                // Do something with the found objects
//                if let objects = objects as? [PFObject] {
//                    for object in objects {
//                        println(object.objectId)
//                    }
//                }
//            } else {
//                // Log details of the failure
//                println("Error: \(error) \(error.userInfo!)")
//            }
//        }
//    }
}