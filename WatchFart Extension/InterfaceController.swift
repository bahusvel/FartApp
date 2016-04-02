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

class InterfaceController: WKInterfaceController, WCSessionDelegate {
	var session: WCSession? = nil
	var audioFilePlayer: WKAudioFilePlayer!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
		if WCSession.isSupported() {
			session = WCSession.defaultSession()
			session!.delegate = self
			session!.activateSession()
		}
		
		let assetURL = NSBundle.mainBundle().URLForResource("fart", withExtension: "wav")
		let asset = WKAudioFileAsset(URL: assetURL!)
		let playerItem = WKAudioFilePlayerItem(asset: asset)
		audioFilePlayer = WKAudioFilePlayer(playerItem: playerItem)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

	@IBAction func fart() {
		session?.sendMessage(["fart":""], replyHandler: nil, errorHandler: nil)
	}
	
	@IBAction func fartLocally() {
		if audioFilePlayer.status == .ReadyToPlay {
			audioFilePlayer.play()
		}
	}
}
