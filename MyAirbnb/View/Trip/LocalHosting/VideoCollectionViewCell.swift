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
import Kingfisher

protocol VideoCollectionViewCellDelegate: class {
    func pushView(url: String, adventureAdditional: [AdventureAdditional])
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
    
//    let currentTimeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "00:00"
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.textAlignment = .left
//        return label
//    }()
    
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
        slider.minimumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "videoSliderThumb"), for: .normal)
        return slider
    }()
    
    var index = 0
    var player: AVPlayer?
    
    var data: RepresentationTrip5?
    
    
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
    
    
    private func configure() {
        contentView.backgroundColor = .black
        
        let tempSize = CGSize(width: contentView.frame.width, height: contentView.frame.height - Standard.subViewHeight)
        
        contentView.addSubview(videoView)
        
        setupGradientLayer()
        
        controlsContainerView.frame = CGRect(origin: .zero, size: tempSize)
        contentView.addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        
        pausePlayBtn.addTarget(self, action: #selector(handlePauseBtn(_:)), for: .touchUpInside)
        controlsContainerView.addSubview(pausePlayBtn)
        
        controlsContainerView.addSubview(videoLengthLabel)
        
        videoSlider.addTarget(self, action: #selector(handleSliderChange(_:)), for: .valueChanged)
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
    
    
    func startAnimate() {
        print("startAnimate")
        UIView.animate(withDuration: 0.7, delay: 0.7, options: [], animations: {
            self.imageView.alpha = 0
            self.titleLabel.alpha = 0
            self.categoryLabel.alpha = 0
            self.hostLabel.alpha = 0
            self.player?.play()
  
            self.player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            // track player progress
            let interval = CMTime(value: 1, timescale: 2)
            self.player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                // get current time
                let seconds = CMTimeGetSeconds(progressTime)
//                let secondsString = String(format: "%02d", Int(seconds) % 60)
//                let minutesString = String(format: "%02d", Int(seconds) / 60)
//                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                // move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
            })
            
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
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
//                var minutesText = Int(seconds) / 60
                guard seconds.isFinite else { return }
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                let secondsText = Int(seconds) % 60
                
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        let tempSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.height - Standard.subViewHeight)
        
        gradientLayer.frame =  CGRect(origin: .zero, size: tempSize)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    func endAnimate() {
        print("endAnimate")
        imageView.alpha = 1
        self.titleLabel.alpha = 1
        self.categoryLabel.alpha = 1
        self.hostLabel.alpha = 1
        player?.pause()
    }
    
//    func setting(data: [String: String], representationData: RepresentationTrip5) {
    func setting(representationData: RepresentationTrip5) {
//        let url = URL(string: data["videoUrl"]!)
        guard !representationData.additional.isEmpty else { return }
        
        if let url = URL(string: representationData.additional[0].media) {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)            
        }
        
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
        
        let imageUrl = URL(string: representationData.additional[0].image1 ?? "")
        imageView.kf.setImage(with: imageUrl)
        
        imageView.frame = CGRect(origin: .zero, size: tempSize)
        titleLabel.text = representationData.name
        categoryLabel.text = representationData.category
        hostLabel.text = representationData.host.username
        
        descLabel.text = representationData.additional[0].additionalDescription
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - handlePauseBtn
    @objc private func handlePauseBtn(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
            pausePlayBtn.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayBtn.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying.toggle()
    }
    
    // MARK: - handleSliderChange
    @objc private func handleSliderChange(_ sender: UISlider) {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completionSeek) in
                // do sth later here
            })
        }
    }
    
    // MARK: - seeDetailBtnDidTap
    @objc private func seeDetailBtnDidTap(_ sender: UIButton) {
        delegate?.pushView(url: data?.url ?? "", adventureAdditional: data?.additional ?? [])
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
            make.centerY.equalTo(videoSlider.snp.centerY)
            make.leading.equalTo(8)
            make.width.height.equalTo(30)
        }
        
//        currentTimeLabel.snp.makeConstraints { (make) in
//            make.centerY.equalTo(videoSlider.snp.centerY)
//            make.leading.equalTo(8)
//            make.height.equalTo(24)
//        }
        
        videoLengthLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(videoSlider.snp.centerY)
            make.trailing.equalTo(-8)
            make.height.equalTo(24)
        }
        
        videoSlider.snp.makeConstraints { (make) in
            make.trailing.equalTo(videoLengthLabel.snp.leading).offset(-8)
            make.bottom.equalToSuperview()
            make.leading.equalTo(pausePlayBtn.snp.trailing).offset(8)
            make.height.equalTo(30)
        }
    }
}
