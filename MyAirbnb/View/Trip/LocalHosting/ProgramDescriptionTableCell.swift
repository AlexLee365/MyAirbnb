//
//  ProgramDescriptionTableCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 29/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class ProgramDescriptionTableCell: UITableViewCell {
    static let identifier = "ProgramDescriptionTableCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "프로그램"
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 25)
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = """
        During our 6-day adventure through
        the Galapagos Islands, we'll be
        supporting the local farms, restaurants,
        and hotels that encourage sustainable
        practices.
        
        We'll visit Monte Mar coffee farm
        conservation project, harvest
        ingredients at Huerta Luna
        permaculture farm, taste fresh ceviche
        and wild goat, catch fish that well eat
        onboard a private yacht, and enjoy a
        tasting menu at Anker Mar to Table, the
        most innovative restaurant in
        Galapagos.
        
        When we're not feasting, we'll kayak,
        snorkel, paddleboard, hike, sail, and
        enjoy sugar sand beaches.
        """
        label.setLineSpacing(lineSpacing: 4.0)
        label.font = UIFont(name: "AirbnbCerealApp-Book", size: 18)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
    }
    
    private func setAutolayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.leading.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
}
