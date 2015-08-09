//
//  EnteredRestaurantDetector.swift
//  Sense360Starter
//
//  Created by Sense360 on 6/22/15.
//  Copyright (c) 2015 Sense360. All rights reserved.
//

import UIKit
import SenseSdk

class EnteredRestaurantDetector: RecipeFiredDelegate {
    
    func setup() {
        setupArrive()
        setupDepart()
    }

    private func setupArrive() {
        let errorPointer = SenseSdkErrorPointer.create()
        // Fire when the user enters a restaurant
        let trigger = FireTrigger.whenEntersPoi(PoiType.Mall, errorPtr: errorPointer)
        
        if let restaurantTrigger = trigger {
            // Recipe defines what trigger, what time of day and how long to wait between consecutive firings
            let restaurantRecipe = Recipe(name: "ArrivedAtQuietLocation",
                trigger: restaurantTrigger,
                // Do NOT restrict the firing to a particular time of day
                timeWindow: TimeWindow.allDay,
                // Wait at least 1 hour between consecutive triggers firing.
                cooldown: Cooldown.create(oncePer: 5, frequency: CooldownTimeUnit.Minutes)!)
            
            // register the unique recipe and specify that when the trigger fires it should call our own "onTriggerFired" method below
            SenseSdk.register(recipe: restaurantRecipe, delegate: self)
        }
        
        if errorPointer.error != nil {
            NSLog("Error!: \(errorPointer.error.message)")
        }
    }
    
    private func setupDepart() {
        let errorPointer = SenseSdkErrorPointer.create()
        // Fire when the user enters a restaurant
        let trigger = FireTrigger.whenEntersPoi(PoiType.Mall, errorPtr: errorPointer)
        
        if let restaurantTrigger = trigger {
            // Recipe defines what trigger, what time of day and how long to wait between consecutive firings
            let restaurantRecipe = Recipe(name: "LeavingQuietLocation",
                trigger: restaurantTrigger,
                // Do NOT restrict the firing to a particular time of day
                timeWindow: TimeWindow.allDay,
                // Wait at least 1 hour between consecutive triggers firing.
                cooldown: Cooldown.create(oncePer: 5, frequency: CooldownTimeUnit.Minutes)!)
            
            // register the unique recipe and specify that when the trigger fires it should call our own "onTriggerFired" method below
            SenseSdk.register(recipe: restaurantRecipe, delegate: self)
        }
        
        if errorPointer.error != nil {
            NSLog("Error!: \(errorPointer.error.message)")
        }
    }

    func abc() {
        let p = Twilio()
        p.sendTextMessage(accountSid: "ACa210095e58b0c83dcb9ac1cba3d9946e", authToken: "62474bd1883e89f50a25236a36e3b665",
            to: "+1ABCDEFGHIF", from: "+14242924032", body: "Hello World")

    }
    
    
    @objc func recipeFired(args: RecipeFiredArgs) {
                // Your user has entered a restaurant!
        NSLog("Recipe \(args.recipe.name) fired at \(args.timestamp).");
        for trigger in args.triggersFired {
            for place in trigger.places {
                
                if(args.recipe.name == "ArrivedAtQuietLocation") {
                    abc()
                } else if(args.recipe.name == "LeavingQuietLocation") {
                    abc()
                } else {
                    fatalError("recipe name wrong \(args.recipe.name)")
                }
            }
        }
    }
}


