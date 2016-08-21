//
//  FullScreanViewConrtoller.swift
//  LGS
//
//  Created by Эрик Вильданов on 20.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit


class FullScreanViewController: UIViewController, UIScrollViewDelegate {
    
    var image = UIImage()
    let fullScreanView = FullScreanView()
    var imageIngex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = fullScreanView
        
        fullScreanView.scrollView.delegate = self
        
        initializeImageView()

    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func initializeImageView(){
        
        fullScreanView.imageView.image = image
        fullScreanView.imageView.contentMode = UIViewContentMode.Center
        fullScreanView.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height)
        
        fullScreanView.scrollView.contentSize = image.size
        
        let scrollViewFrame = fullScreanView.scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / fullScreanView.scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / fullScreanView.scrollView.contentSize.height
        let minScale = min(scaleHeight, scaleWidth)
        
        fullScreanView.scrollView.minimumZoomScale = minScale
        fullScreanView.scrollView.maximumZoomScale = 1
        fullScreanView.scrollView.zoomScale = minScale
        
        centerScrollViewContents()
        
    }
    
    func centerScrollViewContents(){
        let boundsSize = fullScreanView.scrollView.bounds.size
        var contentsFrame = fullScreanView.imageView.frame
        
        if contentsFrame.size.width < boundsSize.width{
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2
        }else{
            contentsFrame.origin.x = 0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2
        }else{
            contentsFrame.origin.y = 0
        }
        self.fullScreanView.imageView.frame = contentsFrame

    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return fullScreanView.imageView
    }
    
    
}



































