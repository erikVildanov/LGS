//
//  FullScreanView.swift
//  LGS
//
//  Created by Эрик Вильданов on 22.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class FullScreanView: UIView {

    let imageView = UIImageView()
    let scrollView = UIScrollView()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blackColor()
        initializeView()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView(){
        
        addSubview(scrollView)
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        scrollView.frame = CGRectMake(0, 0, width, height-60)
        
        let viewsDict = [
            "scrollView" : scrollView,
            "toolBar" : imageView
        ]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[scrollView]|", options: [], metrics: nil, views: viewsDict))
        
        scrollView.addSubview(imageView)
    
    }
    
}
