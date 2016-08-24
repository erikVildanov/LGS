//
//  PageViewController.swift
//  LGS
//
//  Created by Эрик Вильданов on 21.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var photos: [Image] = []
    var currentIndex: Int!
    let navigationBar = UINavigationBar()
    let statusBar = UIView()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : AnyObject]?) {
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        createBarButton()
        
        dataSource = self
        
        if let viewController = viewFullScreanViewController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        }
        
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(deviceDidRotate(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func createBarButton() {
        addBlurEffect()
        view.addSubview(statusBar)
        view.addSubview(navigationBar)
        
        let viewsDict = [
            "navigationBar" : navigationBar,
            "statusBar" : statusBar
        ]
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[statusBar]|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[navigationBar]|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[statusBar(20)][navigationBar(44)]", options: [], metrics: nil, views: viewsDict))
        
        let navItem = UINavigationItem()
        let leftButton = UIBarButtonItem(image: UIImage(named: "Left"), style: .Plain, target: self, action: #selector(goLeftImage))
        let fightButton = UIBarButtonItem(image: UIImage(named: "Right"), style: .Plain, target: self, action: #selector(goRightImage))
            navItem.rightBarButtonItems = [fightButton, leftButton]
        let backButton = UIBarButtonItem(title: "< Back", style: .Plain, target: self, action: #selector(backGalleryViewController))
            navItem.leftBarButtonItem = backButton
            navigationBar.setItems([navItem], animated: false)
        
        
        
        
    }
    
    func addBlurEffect() {
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        navigationBar.translucent = true
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        navigationBar.addSubview(visualEffectView)
        
        // Here you can add visual effects to any UIView control.
        // Replace custom view with navigation bar in above code to add effects to custom view.
    }
    
    func backGalleryViewController(){
        let galleryViewController = GalleryViewController()
        self.presentViewController(galleryViewController, animated: true, completion: nil)
    }
    
    func goLeftImage(){
        if let viewController = viewFullScreanViewController(currentIndex - 1 ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers, direction: .Reverse, animated: true, completion: nil)
        }
    }
    
    func goRightImage(){
        if let viewController = viewFullScreanViewController(currentIndex + 1 ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func deviceDidRotate(notification: NSNotification)
    {
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    func viewFullScreanViewController(index: Int) -> FullScreanViewController? {
        
        if index >= 0 && index < photos.count {
            currentIndex = index
        let fullScreanViewController = FullScreanViewController()
            let data = photos[index]
            if let image = data.url.cachedImage {
                fullScreanViewController.image = image
                fullScreanViewController.imageIngex =  index
        } else {
            data.url.fetchImage { image in
                fullScreanViewController.image = image
                fullScreanViewController.imageIngex =  index
                fullScreanViewController.initializeImageView()
            }
        }
            return fullScreanViewController
        }
        return nil
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? FullScreanViewController {
            var index = viewController.imageIngex
            guard index != NSNotFound && index != 0 else { return nil }
            index = index - 1
            return viewFullScreanViewController(index)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? FullScreanViewController {
            var index = viewController.imageIngex
            guard index != NSNotFound else { return nil }
            index = index + 1
            guard index != photos.count else {return nil}
            return viewFullScreanViewController(index)
        }
        return nil
    }
}



