//
//  VideoCollectionViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

protocol VideoCollectionViewCellDelegate: class {
    func pushView()
}

class VideoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VideoCollectionViewCell"

    private struct Standard {
        static let space: CGFloat = 50
        static let subViewHeight: CGFloat = 170
    }

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let hostLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var index = 0
    var player: AVPlayer!
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.startAnimating()
        return aiv
    }()
    
    let pausePlayBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        return button
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    private let videoView = UIView()
    private let descLabel = UILabel()
    private let seeDetailButton = UIButton()
    private let imageView = UIImageView()
    
    weak var delegate: VideoCollectionViewCellDelegate?
    
    var isPlaying = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        autoLayout()
    }
    
    func startAnimate() {
        print("startAnimate")
        UIView.animate(withDuration: 0.7, delay: 0.7, options: [], animations: {
            self.imageView.alpha = 0
            self.titleLabel.alpha = 0
            self.categoryLabel.alpha = 0
            self.hostLabel.alpha = 0
            self.player.play()
  
            self.player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            self.layoutIfNeeded()
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // This is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayBtn.isHidden = false
            isPlaying = true
        }
    }
    
    func endAnimate() {
        print("endAnimate")
        imageView.alpha = 1
        self.titleLabel.alpha = 1
        self.categoryLabel.alpha = 1
        self.hostLabel.alpha = 1
        player.pause()
    }
    
//    func setting(data: [String: String], representationData: RepresentationTrip5) {
    func setting(representationData: RepresentationTrip5) {
//        let url = URL(string: data["videoUrl"]!)
        let url = URL(string: representationData.media)
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        
        let tempSize = CGSize(width: contentView.frame.width, height: contentView.frame.height - Standard.subViewHeight)
        
        playerLayer.frame = CGRect(origin: .zero, size: tempSize)
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)
        
//        imageView.image = UIImage(named: data["image"]!)
//        titleLabel.text = data["title"]!
//        categoryLabel.text = data["category"]
//        hostLabel.text = "호스트: \n \(data["hostName"] ?? "")"
//        descLabel.text = data["desc"]!
        
        imageView.image = UIImage(named: "adventure")
        imageView.frame = CGRect(origin: .zero, size: tempSize)
        titleLabel.text = "갈라파고스 슬로푸드 사파리"
        categoryLabel.text = "어드벤처"
        hostLabel.text = "Jill & Javier"
        descLabel.text = representationData.representationTrip5Description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //    player.play()
    }
    
    private func configure() {
        contentView.backgroundColor = .black
        
        let tempSize = CGSize(width: contentView.frame.width, height: contentView.frame.height - Standard.subViewHeight)
        
        contentView.addSubview(videoView)
        
        controlsContainerView.frame = CGRect(origin: .zero, size: tempSize)
        contentView.addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        
        pausePlayBtn.addTarget(self, action: #selector(handlePauseBtn(_:)), for: .touchUpInside)
        controlsContainerView.addSubview(pausePlayBtn)
        
        controlsContainerView.addSubview(videoLengthLabel)
        controlsContainerView.addSubview(videoSlider)

        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        descLabel.textColor = .white
        descLabel.textAlignment = .center
        contentView.addSubview(descLabel)
        
        seeDetailButton.setTitle("자세히 알아보기", for: .normal)
        seeDetailButton.setTitleColor(.white, for: .normal)
        seeDetailButton.titleLabel?.textAlignment = .center
        seeDetailButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        seeDetailButton.layer.cornerRadius = 9
        seeDetailButton.layer.borderColor = UIColor.white.cgColor
        seeDetailButton.layer.borderWidth = 0.9
        seeDetailButton.addTarget(self, action: #selector(seeDetailBtnDidTap(_:)), for: .touchUpInside)
        contentView.addSubview(seeDetailButton)
        
        contentView.addSubview(imageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(hostLabel)
    }
    
    @objc private func handlePauseBtn(_ sender: UIButton) {
        if isPlaying {
            player.pause()
            pausePlayBtn.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player.play()
            pausePlayBtn.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying.toggle()
    }
    
    @objc private func seeDetailBtnDidTap(_ sender: UIButton) {
        delegate?.pushView()
    }
    
    private func autoLayout() {
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 50).isActive = true
        
        hostLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50).isActive = true
        hostLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: hostLabel.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: hostLabel.topAnchor, constant: -30).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        
        seeDetailButton.translatesAutoresizingMaskIntoConstraints = false
        seeDetailButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        seeDetailButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Standard.space).isActive = true
        seeDetailButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35).isActive = true
        seeDetailButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.centerXAnchor.constraint(equalTo: seeDetailButton.centerXAnchor).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: seeDetailButton.topAnchor, constant: -20).isActive
            = true
        descLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        pausePlayBtn.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(70)
        }
        
        videoLengthLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.trailing.equalTo(-8)
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
        
        videoSlider.snp.makeConstraints { (make) in
            make.trailing.equalTo(videoLengthLabel.snp.leading)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}
