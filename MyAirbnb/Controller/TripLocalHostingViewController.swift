//
//  TripLocalHostingViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 15/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

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
        ],
        ["image": "kayak",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "어드벤처",
         "title": "카약을 타고 만나는 스웨덴의 다양한 섬",
         "hostName": "Helena",
        ],
        ["image": "boxer",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "복싱",
         "title": "세계 챔피언 '파이어'와 함께 권투하기",
         "hostName": "Keisher",
        ],
        ["image": "concert",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "콘서트",
         "title": "워털루의 숨겨진 재즈 클럽",
         "hostName": "Theo And Jannine",
        ],
        ["image": "lp",
         "videoUrl": "http://tetris.dicemono.xyz/test.mp4",
         "category": "역사 투어",
         "title": "LP판의 마스터",
         "hostName": "DJ Jigüe",
        ]
    ]
    
    var views: [VideoView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
        createView(count: videoData.count)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        views.forEach { $0.player.play()}
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        views.forEach { $0.playerLayer?.frame = $0.videoView.bounds}
    }
    
    private func configure() {
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        
        topView.backButton.setImage(UIImage(named: "cancel"), for: .normal)
        topView.backButton.addTarget(self, action: #selector(closeButtonDidTap(_:)), for: .touchUpInside)
        
        view.addSubview(topView)
    }
    
    @objc func closeButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func createView(count: Int) {
        for index in 0..<count {
            let videoView = VideoView()
            videoView.descLabel.text = videoData[index]["title"]
            
            videoView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(videoView)
            views.append(videoView)
            
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
        
//        videoView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
//        videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.76).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        topView.backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        topView.backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
//        descLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 20).isActive = true
//        descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        descLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
//        seeDetailButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20).isActive = true
//        seeDetailButton.centerXAnchor.constraint(equalTo: descLabel.centerXAnchor).isActive = true
//        seeDetailButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
//        seeDetailButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
}


