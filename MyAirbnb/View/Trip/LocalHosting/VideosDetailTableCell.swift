//
//  VideosDetailTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation

class VideosDetailTableCell: UITableViewCell {
    static let identifier = "VideosDetailTableCell"
    
    private struct Standard {
        static let space: CGFloat = 50
        static let subViewHeight: CGFloat = 170
    }
    
    let videoView = UIView()
    let videoImageView = UIImageView()
    
    var player: AVPlayer!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func startAnimate() {
        print("startAnimate")
        UIView.animate(withDuration: 0.7, delay: 0.7, options: [], animations: {
            self.videoImageView.alpha = 0
            self.player.play()
            self.layoutIfNeeded()
        })
    }
    
    func endAnimate() {
        print("endAnimate")
        videoImageView.alpha = 1
        player.pause()
    }
    
    func setting(data: [String: String]) {
        let url = URL(string: data["videoUrl"]!)
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        
        let tempSize = CGSize(width: contentView.frame.width, height: contentView.frame.height - Standard.subViewHeight)
        
        playerLayer.frame = CGRect(origin: .zero, size: tempSize)
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
        
        videoImageView.image = UIImage(named: data["image"]!)
        videoImageView.frame = CGRect(origin: .zero, size: tempSize)
        
//        titleLabel.text = data["title"]!
//        categoryLabel.text = data["category"]
//        hostLabel.text = "호스트: \n \(data["hostName"] ?? "")"
//        descLabel.text = data["desc"]!
    }
    
    private func configure() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(videoView)
    }
    
    private func setAutolayout() {
        
    }
    
}
