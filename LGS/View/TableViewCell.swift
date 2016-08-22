//
//  TableViewCell.swift
//  LGS
//
//  Created by Эрик Вильданов on 18.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var iconImage = UIImageView()
    var information = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        iconImage.clipsToBounds = true
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        information.translatesAutoresizingMaskIntoConstraints = false
        iconImage.contentMode = .ScaleAspectFit
        
        backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        information.lineBreakMode = .ByWordWrapping
        information.numberOfLines = 0
        
        contentView.addSubview(iconImage)
        contentView.addSubview(information)
        
        let viewsDict = [
            "iconImage" : iconImage,
            "information" : information
        ]
        iconImage.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor, constant: 8).active = true
        iconImage.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor).active = true
        iconImage.widthAnchor.constraintEqualToAnchor(nil, constant: 100).active = true
        iconImage.heightAnchor.constraintEqualToAnchor(nil, constant: 100).active = true
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[iconImage]-3-[information]-3-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-3-[information(>=100)]-3-|", options: [], metrics: nil, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        iconImage.image = nil
        information.text = nil
    }

}
