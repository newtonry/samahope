//
//  ParseClient.swift
//  samahope
//
//  Created by Isaac Ho on 3/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation

class ParseClient {
    class func loadEventsInForeground() -> [Event] {
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
        return myEvents
    }
    class func loadEvents() -> [Event] {
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