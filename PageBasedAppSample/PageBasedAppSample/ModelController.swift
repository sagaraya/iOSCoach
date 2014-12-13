//
//  ModelController.swift
//  PageBasedAppSample
//
//  Created by Keisei SHIGETA on 2014/12/09.
//  Copyright (c) 2014年 Keisei SHIGETA. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var pageData = NSArray()

    override init() {
        super.init()
        // Create the data model.
        let dateFormatter = NSDateFormatter()
        pageData = dateFormatter.monthSymbols //例として、月のデータを使っている
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> ItemCollectionViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let collectionViewController = storyboard.instantiateViewControllerWithIdentifier("ItemCollectionViewController") as ItemCollectionViewController
        collectionViewController.dataObject = self.pageData[index]
        return collectionViewController
    }

    //VCのindex（ページの何番目か）を返す。
    //ページの始まりは0なので注意！
    func indexOfViewController(viewController: ItemCollectionViewController) -> Int {
        if let dataObject: AnyObject = viewController.dataObject {
            return self.pageData.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }

    
    // MARK: - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as ItemCollectionViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }

        //今のVCに対して、前のVCを返す
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as ItemCollectionViewController)
        if index == NSNotFound {
            return nil
        }

        //今のVCに対して、次のVCを返す
        index++
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    // pageControlに表示するpage数を指定
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageData.count
    }

    // ハイライトするpageControllのインデックスを指定。なぜか0を返せばちゃんと動く
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }

}

