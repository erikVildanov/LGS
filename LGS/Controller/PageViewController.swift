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
    }
    
    func createBarButton() {
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[navigationBar]|", options: [], metrics: nil, views: ["navigationBar": navigationBar]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[navigationBar(60)]", options: [], metrics: nil, views: ["navigationBar": navigationBar]))
        
        let navItem = UINavigationItem()
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "Left"), style: .Plain, target: self, action: #selector(goLeftImage))
        let fightButton = UIBarButtonItem(image: UIImage(named: "Right"), style: .Plain, target: self, action: #selector(goRightImage))
        navItem.rightBarButtonItems = [fightButton, leftButton]
        
        let backButton = UIBarButtonItem(title: "< Back", style: .Plain, target: self, action: #selector(backGalleryViewController))
        navItem.leftBarButtonItem = backButton
        navigationBar.setItems([navItem], animated: false)
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



