//
//  InterfaceController.swift
//  WatchFart Extension
//
//  Created by denis lavrov on 3/04/16.
//  Copyright © 2016 bahus. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import CoreMotion

class InterfaceController: WKInterfaceController, WCSessionDelegate {
	var session: WCSession? = nil
	var audioFilePlayer: WKAudioFilePlayer!
	var motionManager: CMMotionManager!
	var motionQueue: NSOperationQueue!
	static var motion = true

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
		
		motionManager = CMMotionManager()
		motionQueue = NSOperationQueue.mainQueue()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
		if WCSession.isSupported() {
			session = WCSession.defaultSession()
			session!.delegate = self
			session!.activateSession()
		}
		
		motionManager.accelerometerUpdateInterval = 1.0
		motionManager.startAccelerometerUpdatesToQueue(motionQueue){accelData, error in
			let a = accelData?.acceleration
			if a?.y < -0.5 {
				self.fart()
			}
		}
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
		motionManager.stopAccelerometerUpdates()
    }

	@IBAction func fart() {
		session?.sendMessage(["fart":""], replyHandler: nil, errorHandler: nil)
	}
	
	@IBAction func motionSelector(value: Bool) {
		InterfaceController.motion = value
	}
}
