
//
//  PageViewController.swift
//  MyRestaurant
//
//  Created by Богдан Костюченко on 21/10/2016.
//  Copyright © 2016 Bogdan Kostyuchenko. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    var headerArray = ["Write","Find"]
    var subheaderArray = ["Create list your favourite restaurants", "Find and mark your favorite restaurants"]
    var imagesArray = ["food","iphoneMap"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayViewController(atIndex index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil }
        guard index < headerArray.count else { return nil }
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? ContentViewController else { return nil }
        
        contentVC.imageFile = imagesArray[index]
        contentVC.header = headerArray[index]
        contentVC.subheader = subheaderArray[index]
        contentVC.index = index
        
        return contentVC
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController)?.index
        index -= 1
        return displayViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController)?.index
        index += 1
        return displayViewController(atIndex: index)
    }
}
