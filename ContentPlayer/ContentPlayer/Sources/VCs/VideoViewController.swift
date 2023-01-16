//
//  VideoViewController.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/13.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var subscriptLabel: UILabel!
    
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    private var subScript: SubScript!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVideo()
        setSubScript()
    }
    
    private func setVideo() {
        if let path = Bundle.main.path(forResource: "typhoon", ofType: "mp4") {
            let url = NSURL(fileURLWithPath: path)
            player = AVPlayer(url: url as URL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resizeAspect
            videoView.layer.addSublayer(playerLayer)
        }
    }
    
    private func setSubScript() {
        guard let path = Bundle.main.path(forResource: "typhoon_script", ofType: "json"),
              let jsonString = try? String(contentsOfFile: path),
              let jsonData = jsonString.data(using: .utf8)
        else {
            return
        }
        subScript = JsonManager.shared.parse(type: SubScript.self, data: jsonData)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPlay()
    }
    
    private func videoPlay() {
        player.play()

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            let time = self.player.currentTime().seconds
            let timeString = Int(time).timeFormat()
            DispatchQueue.main.async { [weak self] in
                self?.timeLabel.text = timeString
                self?.subscriptLabel.text = self?.subScript.currentScript(time: time)
            }
        })
    }
}
