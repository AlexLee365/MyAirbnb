//
//  TripLocalHostingViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation

class TripLocalHostingViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    let topView = TableviewTopView()
    
    let videoData: [[String: String]] = [
        ["image": "adventure",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "어드벤처",
         "title": "갈라파고스 슬로푸드 사파리",
         "hostName": "Jill & Javier",
         "desc": "Island hop around Galapagos for wild, up-close encounters and local food.",
        ],
        ["image": "kayak",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "어드벤처",
         "title": "카약을 타고 만나는 스웨덴의 다양한 섬",
         "hostName": "Helena",
         "desc": "Island hop around Galapagos for wild, up-close encounters and local food.",
        ],
        ["image": "boxer",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "복싱",
         "title": "세계 챔피언 '파이어'와 함께 권투하기",
         "hostName": "Keisher",
         "desc": "Island hop around Galapagos for wild, up-close encounters and local food.",
        ],
        ["image": "concert",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "콘서트",
         "title": "워털루의 숨겨진 재즈 클럽",
         "hostName": "Theo And Jannine",
         "desc": "Island hop around Galapagos for wild, up-close encounters and local food.",
        ],
        ["image": "lp",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "역사 투어",
         "title": "LP판의 마스터",
         "hostName": "DJ Jigüe",
         "desc": "Island hop around Galapagos for wild, up-close encounters and local food.",
        ]
    ]
    
    var views: [VideoView] = []
    var pageCount = 0 {
        willSet {
//            animateTimerStart()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
        
        createView(count: videoData.count)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        animateTimerStart()
        scrollView.setContentOffset(CGPoint(x: (view.frame.width * CGFloat(pageCount)), y: 0), animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        views.forEach { $0.playerLayer?.frame = $0.videoView.bounds}
        
    }
    
    let delay: Double = 1
    var aniamte = Timer()

    func animateTimerStart() {
        aniamte = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(animate), userInfo: nil, repeats: false)
    }
    
    @objc private func animate() {
        UIView.animate(withDuration: delay, animations: {
            self.views[self.pageCount].blackView.alpha = 1
            self.views[self.pageCount].layoutIfNeeded()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.views[self.pageCount].blackView.isHidden = true
            self.views[self.pageCount].imageView.isHidden = true
            self.views[self.pageCount].player.play()
        }
    }
    
    private func configure() {
        view.backgroundColor = .black
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        topView.backButton.setImage(UIImage(named: "cancel"), for: .normal)
        topView.backButton.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
        
        view.addSubview(topView)
    }
    
    @objc func closeButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    var timers = [Timer]()
    private func createView(count: Int) {
        for index in 0..<count {
            let videoView = VideoView()
            
            videoView.imageView.image = UIImage(named: videoData[index]["image"]!)
            videoView.categoryLabel.text = videoData[index]["category"]
            videoView.titleLabel.text = videoData[index]["title"]
            videoView.hostLabel.text = "호스트: \n \(videoData[index]["hostName"] ?? "")"
            
            videoView.url = URL(string: videoData[index]["videoUrl"]!)!
            videoView.descLabel.text = videoData[index]["desc"]
            
            
            videoView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(videoView)
            views.append(videoView)
            
//            videoView.delegate = self
            
            switch index {
            case 0:
                views[0].topAnchor.constraint(
                    equalTo: scrollView.topAnchor).isActive = true
                views[0].bottomAnchor.constraint(
                    equalTo: scrollView.bottomAnchor).isActive = true
                views[0].leadingAnchor.constraint(
                    equalTo: scrollView.leadingAnchor).isActive = true
                views[0].widthAnchor.constraint(
                    equalTo: scrollView.widthAnchor).isActive = true
                views[0].heightAnchor.constraint(
                    equalTo: scrollView.heightAnchor).isActive = true
            case count - 1:
                views[count - 1].topAnchor.constraint(
                    equalTo: scrollView.topAnchor).isActive = true
                views[count - 1].leadingAnchor.constraint(
                    equalTo: views[count - 2].trailingAnchor).isActive = true
                views[count - 1].trailingAnchor.constraint(
                    equalTo: scrollView.trailingAnchor).isActive = true
                views[count - 1].bottomAnchor.constraint(
                    equalTo: scrollView.bottomAnchor).isActive = true
                views[count - 1].widthAnchor.constraint(
                    equalTo: scrollView.widthAnchor).isActive = true
                views[count - 1].heightAnchor.constraint(
                    equalTo: scrollView.heightAnchor).isActive = true
            default :
                views[index].topAnchor.constraint(
                    equalTo: scrollView.topAnchor).isActive = true
                views[index].bottomAnchor.constraint(
                    equalTo: scrollView.bottomAnchor).isActive = true
                views[index].leadingAnchor.constraint(
                    equalTo: views[index - 1].trailingAnchor).isActive = true
                views[index].widthAnchor.constraint(
                    equalTo: scrollView.widthAnchor).isActive = true
                views[index].heightAnchor.constraint(
                    equalTo: scrollView.heightAnchor).isActive = true
            }
        }
    }
    
    private func setAutolayout() {
        let guide = view.safeAreaLayoutGuide
        
        scrollView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        topView.backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        topView.backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}


// MARK: - UIScrollViewDelegate

extension TripLocalHostingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageCount = Int(scrollView.bounds.minX / scrollView.bounds.width)
        print(Int(scrollView.bounds.minX / scrollView.bounds.width))
    }
}

// MARK: - VideoViewDelegate

//extension TripLocalHostingViewController: VideoViewDelegate {
//    func pushView() {
//        let videoDetailVC = VideosDetailViewController()
//        navigationController?.pushViewController(videoDetailVC, animated: true)
//    }
//}
