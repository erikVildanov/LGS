//
//  GalleryViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 20.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    var collectionData = CollectionDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()

        collectionView = UICollectionView(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height), collectionViewLayout: flowLayout)
        
        collectionView.dataSource = collectionData
        collectionView.delegate = self
        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "cellImage")
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: [], metrics: nil, views: ["collectionView" : collectionView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collectionView]|", options: [], metrics: nil, views: ["collectionView" : collectionView]))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(self.view.frame.width, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let frame : CGRect = self.view.frame
        let margin  = (frame.width - 90 * 3) / 6.0
        return UIEdgeInsetsMake(10, margin, 10, margin)
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let fullScreanViewController = FullScreanViewController()
        fullScreanViewController.img(collectionData.image, indexPath: indexPath.row)
        self.navigationController?.pushViewController(fullScreanViewController, animated: true)
    }
}
