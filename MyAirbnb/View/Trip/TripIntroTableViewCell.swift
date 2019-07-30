//
//  TripIntroTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//
import UIKit

protocol TripIntroTableViewCellDelegate: class {
    func presentView(index: IndexPath)
}

class TripIntroTableViewCell: UITableViewCell {
    static let identifier = "tripIntroTableViewCell"
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 2
        static let lineSpacing: CGFloat = 13.0
        static let itemSpacing: CGFloat = 0.0
        static let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 30, right: 20)
        
        static let nextOffset: CGFloat = 8
    }
    
    
    
//    let gradientView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .blue
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    let redTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 14)
        label.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        label.text = "에어비앤비 트립"
        return label
    }()
    
    let introTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 38)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "현지인이 호스팅하는\n하나뿐인 특별한 체험"
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
//    private var gradient = CAGradientLayer()
    
    weak var delegate: TripIntroTableViewCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    var setLayout = true
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if setLayout {
//            createGradient()
//            gradient.frame = gradientView.bounds
//            setLayout = false
//        }
//    }
    
//    private func createGradient() {
//
//        gradient.colors = [UIColor.gray.cgColor, UIColor.red.cgColor]
//        gradient.locations = [0.9, 1]
//        gradientView.layer.mask = gradient
//    }
    
    private func configure() {
//        contentView.addSubview(gradientView)
        self.backgroundColor = .black
        self.selectionStyle = .none
        
        contentView.addSubview(redTitleLabel)
        contentView.addSubview(introTitleLabel)

        
        collectionView.dataSource = self
        collectionView.register(TripIntroCollectionViewCell.self, forCellWithReuseIdentifier: TripIntroCollectionViewCell.identifier)
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    private func setAutolayout() {
//        gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        gradientView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
//        gradientView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7).isActive = true
        
        redTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        redTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120).isActive = true
        redTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        introTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        introTitleLabel.topAnchor.constraint(equalTo: redTitleLabel.bottomAnchor, constant: 15).isActive = true
        introTitleLabel.centerXAnchor.constraint(equalTo: redTitleLabel.centerXAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: introTitleLabel.bottomAnchor, constant: 30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}


// MARK: - UICollectionViewDataSource

extension TripIntroTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripIntroCollectionViewCell.identifier, for: indexPath) as! TripIntroCollectionViewCell
        
        cell.imageView.image = UIImage(named: tripIntroDatas[indexPath.row].image)
        cell.categoryLabel.text = tripIntroDatas[indexPath.row].category
        cell.titleLabel.text = tripIntroDatas[indexPath.row].title
        cell.hostNameLabel.text = tripIntroDatas[indexPath.row].hostName
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension TripIntroTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.presentView(index: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TripIntroTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        
        let horizontalSpacing = lineSpacing + horizontalInset + UI.nextOffset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)
        let cellHeight = collectionView.frame.height * 0.9
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}


