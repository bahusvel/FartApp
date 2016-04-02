//
//  ViewController.swift
//  FartApp
//
//  Created by denis lavrov on 3/04/16.
//  Copyright © 2016 bahus. All rights reserved.
//

import UIKit
import AVFoundation
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
	var soundID: SystemSoundID = 0
	var mainBundle: CFBundleRef = CFBundleGetMainBundle()
	var session: WCSession?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		if let ref: CFURLRef = CFBundleCopyResourceURL(mainBundle, "fart", "wav", nil) {
			AudioServicesCreateSystemSoundID(ref, &soundID)
		}
		if (WCSession.isSupported()) {
			session = WCSession.defaultSession()
			session!.delegate = self;
			session!.activateSession()
		}
		
	}
	
	func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
		AudioServicesPlaySystemSound(soundID)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func fart(sender: UIButton) {
		AudioServicesPlaySystemSound(soundID)
	}

}

