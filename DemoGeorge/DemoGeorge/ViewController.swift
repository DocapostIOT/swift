//
//  ViewController.swift
//  DemoGeorge
//
//  Created by Quentin Gras on 06/01/2017.
//  Copyright © 2017 Quentin Gras. All rights reserved.
//

import AVKit
import AVFoundation


import UIKit

class ViewController: UIViewController {
    
    var player:AVPlayer?;
    var playerViewController:AVPlayerViewController?;
    
    
    @IBOutlet var butt: UIButton!
    @IBAction func back(_ sender: Any) {
        butt.alpha = 0;
        playerViewController?.player!.pause();
        playerViewController?.view.removeFromSuperview();

    }
    
    @IBAction func tap2(_ sender: Any) {
        playVid(name: "02");
    }
    @IBAction func tap6(_ sender: Any) {
        playVid(name: "06");
    }
    @IBAction func tap7(_ sender: Any) {
        playVid(name: "07");
    }
    @IBAction func tap5(_ sender: Any) {
        playVid(name: "05");
    }
    @IBAction func tap4(_ sender: Any) {
        playVid(name: "04");
    }
    @IBAction func tap3(_ sender: Any) {
        playVid(name: "03");
    }
    @IBAction func tap1(_ sender: Any) {
        playVid(name: "01");
    }
    
    
    
    

    
    func playVid(name : String){
       
        NSLog(name);
        
        

        let urlpath     = Bundle.main.path(forResource: name, ofType: "mp4")
        let url         = NSURL.fileURL(withPath: urlpath!)

        player = AVPlayer(url: url as URL)
            
            
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player
        playerViewController?.showsPlaybackControls = false
        playerViewController?.view.frame = self.view.frame
        self.view.insertSubview(playerViewController!.view, at: 9);
            

            
        
        
        
   
        player?.volume = 10
        
        
        var item = AVPlayerItem.init(url: url)
        
        
        self.player?.replaceCurrentItem(with: item)
        NotificationCenter.default.removeObserver(self);
        NotificationCenter.default.addObserver(self, selector: #selector(self.itemDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem);
        self.playerViewController?.player!.play()
        butt.alpha = 1;
   
    }
    
    
    
    func itemDidFinishPlaying(){
        butt.alpha = 0;
        playerViewController?.view.removeFromSuperview();
 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        butt.alpha = 0;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

