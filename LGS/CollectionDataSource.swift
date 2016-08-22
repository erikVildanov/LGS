//
//  CollectionDataSource.swift
//  LGS
//
//  Created by Эрик Вильданов on 20.08.16.
//  Copyright © 2016 ErikVildanov. All rights reserved.
//

import UIKit

class CollectionDataSource: NSObject ,UICollectionViewDataSource{
    
    var image:[Image] = []
    
    override init(){
        super.init()
        populateData()
    }
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("image", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let str = dict["url"] as! String
                        if let url = NSURL(string: str) {
                            let img = Image(url: url)
                            image.append(img)
                        }
                    }
                }
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return image.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellImage", forIndexPath: indexPath) as! CollectionViewCell
        
        let data = image[indexPath.row]
        
        cell.imageUrl = data.url
        
        if let image = data.url.cachedImage {
            cell.backgroundView = UIImageView(image: image)
            cell.backgroundView!.contentMode = .ScaleAspectFit
        } else {
            data.url.fetchImage { img in
                if cell.imageUrl == data.url {
                    cell.backgroundView = UIImageView(image: img)
                    cell.backgroundView!.contentMode = .ScaleAspectFit
                }
            }
        }
        return cell
    }
    
    
    
    
    
}








































