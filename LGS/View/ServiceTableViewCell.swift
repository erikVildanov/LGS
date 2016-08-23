//
//  ServiceTableViewCell.swift
//  LGS
//
//  Created by Эрик Вильданов on 23.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    let message = UILabel()
    let idLbl = UILabel()
    let dateLbl = UILabel()
    let ratingLbl = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None

        message.translatesAutoresizingMaskIntoConstraints = false
        idLbl.translatesAutoresizingMaskIntoConstraints = false
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        ratingLbl.translatesAutoresizingMaskIntoConstraints = false
        
        dateLbl.textAlignment = .Right
        ratingLbl.textAlignment = .Center
        message.layer.shadowRadius = 5.0
        message.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        idLbl.backgroundColor = UIColor.whiteColor()
        dateLbl.backgroundColor = UIColor.whiteColor()
        message.lineBreakMode = .ByWordWrapping
        message.numberOfLines = 0
        
        contentView.addSubview(message)
        contentView.addSubview(idLbl)
        contentView.addSubview(dateLbl)
        contentView.addSubview(ratingLbl)
        
        let viewsDict = ["message" : message, "idLbl": idLbl, "dateLbl": dateLbl, "ratingLbl": ratingLbl]
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[idLbl(>=50)][dateLbl(>=200)]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[ratingLbl]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[message]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[idLbl(20)][ratingLbl(20)][message(>=100)]|", options: [], metrics: nil, views: viewsDict))
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
        message.text = nil
        idLbl.text = nil
        dateLbl.text = nil
        ratingLbl.text = nil
        
    }

}
