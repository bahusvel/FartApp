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
	var mainBundle: CFBundleRef = CFBundleGetMainBundle()
	var session: WCSession?
	var backgroundPlayers: [AVAudioPlayer] = []
	var counter = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		do {
			for url in getFileURLS() {
				let bp = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: url))
				bp.prepareToPlay()
				backgroundPlayers.append(bp)
			}
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
			try AVAudioSession.sharedInstance().setActive(true)
			UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
		} catch {
			print("Player setup failed")
		}
		
		if (WCSession.isSupported()) {
			session = WCSession.defaultSession()
			session!.delegate = self;
			session!.activateSession()
		}
		
		
	}
	
	func getFileURLS() -> [String] {
		let wavs = NSBundle.mainBundle().pathsForResourcesOfType("wav", inDirectory: "")
		let mp3s = NSBundle.mainBundle().pathsForResourcesOfType("mp3", inDirectory: "")
		return wavs + mp3s
	}
	
	func playSound(){
		backgroundPlayers[counter % backgroundPlayers.count].play()
		counter += 1
	}
	
	func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
		print("Received Here")
		playSound()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func fart(sender: UIButton) {
		playSound()
	}

}

