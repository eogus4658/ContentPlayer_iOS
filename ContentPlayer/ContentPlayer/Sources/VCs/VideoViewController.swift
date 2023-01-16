//
//  VideoViewController.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/13.
//

import UIKit
import AVFoundation
import AVKit
import FirebaseStorage

class VideoViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var subscriptLabel: UILabel!
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var subScript: SubScript?
    
    let storage = Storage.storage()
    var videoPath: String?
    var scriptPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        if let videoPath = videoPath {
            setVideoStorage(path: videoPath)
        } else {
            setVideo()
        }
        
        if let scriptPath = scriptPath {
            setSubScriptStorage(path: scriptPath)
        } else {
            setSubScript()
        }
    }
    
    private func setVideoStorage(path: String) {
        storage.reference(forURL: "gs://contentplayer-a8f09.appspot.com/\(path)").downloadURL { (url, err) in
            guard let url = url else {
                print("Error getting firebase storage: \(err)")
                return
            }
            self.player = AVPlayer(url: url)
            self.playerLayer = AVPlayerLayer(player: self.player)
            self.playerLayer?.videoGravity = .resizeAspect
            if let playerLayer = self.playerLayer {
                self.videoView.layer.addSublayer(playerLayer)
                self.videoPlay()
            }
        }
    }
    
    private func setVideo() {
        if let path = Bundle.main.path(forResource: "typhoon", ofType: "mp4") {
            let url = NSURL(fileURLWithPath: path)
            player = AVPlayer(url: url as URL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = .resizeAspect
            videoView.layer.addSublayer(playerLayer!)
            self.videoPlay()
        }
    }
    
    private func setSubScriptStorage(path: String) {
        storage.reference(forURL: "gs://contentplayer-a8f09.appspot.com/\(path)").downloadURL { (url, err) in
            guard let url = url,
                  let data = try? Data(contentsOf: url) else {
                print("Error getting firebase storage")
                return
            }
            self.subScript = JsonManager.shared.parse(type: SubScript.self, data: data)
        }
    }
    
    private func setSubScript() {
        guard let path = Bundle.main.path(forResource: "CNUH_QUERY", ofType: "json"),
              let jsonString = try? String(contentsOfFile: path),
              let jsonData = jsonString.data(using: .utf8)
        else {
            return
        }
        subScript = JsonManager.shared.parse(type: SubScript.self, data: jsonData)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = videoView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func videoPlay() {
        player?.play()

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            guard let time = self.player?.currentTime().seconds else { return }
            let timeString = Int(time).timeFormat()
            DispatchQueue.main.async { [weak self] in
                self?.timeLabel.text = timeString
                self?.subscriptLabel.text = self?.subScript?.currentScript(time: time)
            }
        })
    }
}
