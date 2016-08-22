//
//  GalleryViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 20.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate {
    
    let galleryView = GalleryView()
    var collectionData = CollectionDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = galleryView
        galleryView.collectionView.delegate = self
        galleryView.collectionView.dataSource = collectionData
        galleryView.collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "cellImage")
        createToolBarButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createToolBarButton() {
        galleryView.toolBar.items = [
            UIBarButtonItem(title: "Gallery", style: UIBarButtonItemStyle.Plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "List", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(jumpListViewController)),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Service", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(jumpServiceViewController))
        ]
    }
    
    func jumpListViewController(){
        let listViewController = ListViewController()
        listViewController.modalTransitionStyle = .CrossDissolve
        self.presentViewController(listViewController, animated: true, completion: nil)
    }
    
    func jumpServiceViewController(){
        
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
        let pageViewController = PageViewController()
        pageViewController.photos = collectionData.image
        pageViewController.currentIndex = indexPath.row
        pageViewController.modalTransitionStyle = .CrossDissolve
        self.presentViewController(pageViewController, animated: true, completion: nil)
    }
}




































