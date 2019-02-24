//
//  VideoPlayerViewController.swift
//  rechack
//
//  Created by 南田宗太郎 on 2019/02/23.
//  Copyright © 2019 南田宗太郎. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerViewController: UIViewController {
    
    @IBOutlet weak var videoPlayerVIew: AVPlayerView!
    var videoPath : String!
    var player : AVPlayer?
    var url : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //guard let videoUrl:URL = URL(string: self.videoPath) else {return}
        guard let videoUrl:URL = URL(string: self.url) else {return}
        self.player = AVPlayer(url: videoUrl)
        
        guard let playerLayer:AVPlayerLayer = videoPlayerVIew.layer as? AVPlayerLayer else {return}
        
        
        playerLayer.player = player
        
        
        //self.performSegue(withIdentifier: "toPlay", sender: playerLayer)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    @IBAction func start(_ sender: Any) {
        
        player?.play()
    }
    @IBAction func stop(_ sender: Any) {
        player?.pause()
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPlay" {
            guard let PlayViewController = segue.destination as? PlayViewController else {return}
            guard let video = sender as? AVPlayerLayer else {return}
            PlayViewController.video = video
        }
    }
 */

}


class AVPlayerView: UIView {
    
    // AVPlayerのgetterとsetter
    override class var layerClass: AnyClass {
        get{
            return AVPlayerLayer.self
        }
    }
    
}

