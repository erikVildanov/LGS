//
//  GalleryView.swift
//  LGS
//
//  Created by Эрик Вильданов on 20.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class GalleryView: UIView {

    let scrollView = UIScrollView()
    let contanerView = [UIView(), UIView(), UIView()]
    let imageView = [UIImageView(),UIImageView(),UIImageView()]
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        scrollView.backgroundColor = UIColor.yellowColor()
        initializeScrillView()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeScrillView(){
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView]))
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width*3, 0)
        scrollView.scrollRectToVisible(UIScreen.mainScreen().bounds, animated: false)
            //print(UIScreen.mainScreen().bounds.size.width)
    }
    
    func initializeImageView(index: Int, image: [Image]){
        contanerView[0].frame = CGRectMake(scrollView.frame.size.width, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
        imageView[0].frame = CGRectMake(0, 0, contanerView[0].frame.size.width, contanerView[0].frame.size.height)
        if let url = image[index].url {
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
        contanerView[0].addSubview(imageView[0])
        scrollView.addSubview(contanerView[0])
        
        if index - 1 > 0 {
            
            contanerView[1].frame = CGRectMake(0, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
            imageView[1].frame = CGRectMake(0, 0, contanerView[1].frame.size.width, contanerView[1].frame.size.height)
            if let url = image[index-1].url {
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
            contanerView[1].addSubview(imageView[1])
            scrollView.addSubview(contanerView[1])
        }
        
        if index + 1 < image.count {
            
            contanerView[2].frame = CGRectMake(scrollView.frame.size.width*2, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
            imageView[2].frame = CGRectMake(0, 0, contanerView[2].frame.size.width, contanerView[2].frame.size.height)
            if let url = image[index+1].url {
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
            contanerView[2].addSubview(imageView[2])
            scrollView.addSubview(contanerView[2])
        }
    }
    
    
    
}
