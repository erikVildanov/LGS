//
//  FullScreanViewConrtoller.swift
//  LGS
//
//  Created by Эрик Вильданов on 20.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit


class FullScreanViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    
    var image: [Image] = []
    var indexPath = 0
    var page = 2
    
    let testView = [UIView(),UIView(),UIView()]
    let imageView = [UIImageView(),UIImageView(),UIImageView()]
    
    func img(image: [Image], indexPath: Int) {
        self.image = image
        self.indexPath = indexPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = UIColor.yellowColor()
        configureScrollView()
        addViewInScrollView()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    func configureScrollView() {
        
        self.view.addSubview(scrollView)
        scrollView.frame = CGRectMake(0, 0, 320, 568)
        page = 1

        scrollView.pagingEnabled = true
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, 0)
        var newFrame = scrollView.frame
        newFrame.origin.x = newFrame.size.width
        scrollView.scrollRectToVisible(newFrame, animated: false)
        scrollView.delegate = self
    }
    
    func addViewInScrollView() {
        testView[0].frame = CGRectMake(scrollView.frame.size.width, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
        imageView[0].frame = CGRectMake(0, 0, testView[0].frame.size.width, testView[0].frame.size.height)
        if let url = image[indexPath].url {
        let request = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config,delegate: nil, delegateQueue:NSOperationQueue.mainQueue())
        let task = session.dataTaskWithRequest(request, completionHandler: {data, _, _ -> Void in
            if let data = data {
                self.imageView[0].image = UIImage(data: data)
            }
        })
        task.resume()
        }
        imageView[0].contentMode = .ScaleAspectFit
        imageView[0].center.y = 230
        testView[0].addSubview(imageView[0])
        scrollView.addSubview(testView[0])
        
        if indexPath - 1 > 0 {
            
            testView[1].frame = CGRectMake(0, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
            imageView[1].frame = CGRectMake(0, 0, testView[1].frame.size.width, testView[1].frame.size.height)
            if let url = image[indexPath-1].url {
                let request = NSURLRequest(URL: url)
                let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                let session = NSURLSession(configuration: config,delegate: nil, delegateQueue:NSOperationQueue.mainQueue())
                let task = session.dataTaskWithRequest(request, completionHandler: {data, _, _ -> Void in
                    if let data = data {
                        self.imageView[1].image = UIImage(data: data)
                    }
                })
                task.resume()
            }
            imageView[1].contentMode = .ScaleAspectFit
            imageView[1].center.y = 230
            testView[1].addSubview(imageView[1])
            scrollView.addSubview(testView[1])
        }
        
        if indexPath + 1 < image.count {
            
            testView[2].frame = CGRectMake(scrollView.frame.size.width*2, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
            imageView[2].frame = CGRectMake(0, 0, testView[2].frame.size.width, testView[2].frame.size.height)
            if let url = image[indexPath+1].url {
                let request = NSURLRequest(URL: url)
                let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                let session = NSURLSession(configuration: config,delegate: nil, delegateQueue:NSOperationQueue.mainQueue())
                let task = session.dataTaskWithRequest(request, completionHandler: {data, _, _ -> Void in
                    if let data = data {
                        self.imageView[2].image = UIImage(data: data)
                    }
                })
                task.resume()
            }
            imageView[2].contentMode = .ScaleAspectFit
            imageView[2].center.y = 230
            testView[2].addSubview(imageView[2])
            scrollView.addSubview(testView[2])
        }
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        let currentPage = scrollView.contentOffset.x / UIScreen.mainScreen().bounds.size.width
        if (currentPage % 1) == 0
        {
            if page < Int(currentPage)
            {
                page = Int(currentPage)
                if indexPath < image.count-1{
                    indexPath += 1
                }
                configureScrollView()
                
            }
            if page > Int(currentPage)
            {
                page = Int(currentPage)
                if indexPath > 1 {
                    indexPath -= 1
                }
                configureScrollView()
                
            }
        }
    }
    
    
}

