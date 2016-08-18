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
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        information.translatesAutoresizingMaskIntoConstraints = false
        iconImage.contentMode = .ScaleAspectFit
        
        information.backgroundColor = UIColor.yellowColor()
        
        information.lineBreakMode = .ByWordWrapping
        information.numberOfLines = 0
        
        contentView.addSubview(iconImage)
        contentView.addSubview(information)
        
        let viewsDict = [
            "iconImage" : iconImage,
            "information" : information
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-3-[iconImage(100)]-8-[information]-3-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-3-[iconImage(100)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-3-[iconImage(100)]-8-[information]-3-|", options: [], metrics: nil, views: viewsDict))
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
