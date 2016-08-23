//
//  ServiceTableViewCell.swift
//  LGS
//
//  Created by Эрик Вильданов on 23.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    var information = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None

        information.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        information.lineBreakMode = .ByWordWrapping
        information.numberOfLines = 0
        
        contentView.addSubview(information)
        
        let viewsDict = ["information" : information]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-3-[information]-3-|", options: [], metrics: nil, views: viewsDict))
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
        information.text = nil
    }

}
