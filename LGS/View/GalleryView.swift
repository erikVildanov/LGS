//
//  GalleryView.swift
//  LGS
//
//  Created by Эрик Вильданов on 20.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class GalleryView: UIView {

    var collectionView: UICollectionView!
    let navigationBar = UINavigationBar()
    let toolBar = UIToolbar()
    
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
    
    private func initializeView(){
        let flowLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: flowLayout)
        
        addSubview(collectionView)
        addSubview(navigationBar)
        addSubview(toolBar)

        let viewsDict = [
            "collectionView" : collectionView,
            "navigationBar" : navigationBar,
            "toolBar" : toolBar
        ]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[navigationBar]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[toolBar]|", options: [], metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[navigationBar(60)][collectionView][toolBar(50)]|", options: [], metrics: nil, views: viewsDict))
        
        let navItem = UINavigationItem(title: "Gallery")
        navigationBar.setItems([navItem], animated: false)
        
    }
    
}



































