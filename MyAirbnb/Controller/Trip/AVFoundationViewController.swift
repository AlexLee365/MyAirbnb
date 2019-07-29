//
//  AVFoundationViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 16/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import AVFoundation

class AVFoundationViewController: UIViewController {

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
    
    let topView = TableviewTopView()
    
    var beginPageCount = 0
    
    var pageCount = 0 {
        willSet {
            print("[Log] newValue :", newValue)
            print("[Log] pageCount :", pageCount)
            if pageCount != newValue {
                cells[newValue].startAnimate()
                cells[pageCount].endAnimate()
            }
        }
    }
    
    var cells = [VideoCollectionViewCell]()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configure()
        autoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWIllAppear")
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
        cells[beginPageCount].startAnimate()
        cells[pageCount].startAnimate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cells[pageCount].endAnimate()
    }
    
    var isLayout = true
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if isLayout {
            let collectionViewWidth: CGFloat = view.frame.width - (view.safeAreaInsets.right + view.safeAreaInsets.left)
            let collectionViewHeight: CGFloat = view.frame.height - view.safeAreaInsets.top
            
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: collectionViewWidth, height: collectionViewHeight)
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        isLayout = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidlayoutSubviews")
    }
    
    private func configure() {
        view.backgroundColor = .black
        
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        view.addSubview(collectionView)
        
        topView.delegate = self
        topView.backButton.setImage(UIImage(named: "cancel"), for: .normal)
        view.addSubview(topView)
    }
    
    private struct Standard {
        static let space: CGFloat = 10
    }
    
    private func autoLayout() {
        let guide = view.safeAreaLayoutGuide
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
}

extension AVFoundationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.setting(data: videoData[indexPath.row])
        cells.append(cell)
        
        return cell
    }
}

extension AVFoundationViewController: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cells[indexPath.item].startAnimate()
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cells[indexPath.item].endAnimate()
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageCount = Int(scrollView.bounds.minX / scrollView.bounds.width)
    }
}

// MARK: - VideoCollectionViewCellDelegate

extension AVFoundationViewController: VideoCollectionViewCellDelegate {
    func pushView() {
        let videosDetailVC = VideosDetailViewController()
        navigationController?.pushViewController(videosDetailVC, animated: true)
    }
}

extension AVFoundationViewController: TableviewTopViewDelegate {
    func popView() {
        dismiss(animated: true, completion: nil)
    }
}
