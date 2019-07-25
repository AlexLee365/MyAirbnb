//
//  FooterView.swift
//  MyAirbnb
//
//  Created by Solji Kim on 25/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class FooterView: UICollectionReusableView {
    static let identifier = "FooterView"
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let extraLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(footerLabel)
        self.addSubview(extraLabel)
    }
    
    private func setAutolayout() {
        footerLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(12)
        }
        
        extraLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(footerLabel.snp.trailing).offset(2)
            make.top.equalTo(12)
        }
    }
    
    func configure(title: String, extra: String) {
        footerLabel.text = title
        extraLabel.text = extra
    }
}
