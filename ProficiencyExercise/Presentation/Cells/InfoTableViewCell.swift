//
//  InfoTableViewCell.swift
//  ProficiencyExercise
//
//  Created by Jeni on 19/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import UIKit

class InfoTableViewCell: UITableViewCell {

    let feedImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
       /* if UIDevice.current.orientation.isLandscape {
            
            //configure imageview
            contentView.addSubview(feedImageView)
            feedImageView.translatesAutoresizingMaskIntoConstraints = false
            feedImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
            feedImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            feedImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            feedImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            
            // configure titleLabel
            contentView.addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.leadingAnchor.constraint(equalTo: feedImageView.trailingAnchor).isActive = true
            nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            nameLabel.numberOfLines = 0
            nameLabel.font = AppConstants.FontStyle.Font.avenir_medium.font(size: AppConstants.FontStyle.Font.Size.medium)
            
            // configure authorLabel
            contentView.addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.leadingAnchor.constraint(equalTo: feedImageView.trailingAnchor).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
            descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = AppConstants.FontStyle.Font.avenir_regular.font(size: AppConstants.FontStyle.Font.Size.small)
            descriptionLabel.textColor = UIColor.darkGray
        }
        else {*/
         
            //configure imageview
            contentView.addSubview(feedImageView)
            feedImageView.translatesAutoresizingMaskIntoConstraints = false
            feedImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
            feedImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            feedImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            feedImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            
            
            // configure titleLabel
            contentView.addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
            nameLabel.topAnchor.constraint(equalTo: feedImageView.bottomAnchor).isActive = true
            nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            nameLabel.numberOfLines = 0
            nameLabel.font = AppConstants.FontStyle.Font.avenir_medium.font(size: AppConstants.FontStyle.Font.Size.medium)
            
            // configure authorLabel
            contentView.addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
            descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = AppConstants.FontStyle.Font.avenir_regular.font(size: AppConstants.FontStyle.Font.Size.small)
            descriptionLabel.textColor = UIColor.darkGray
//        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
