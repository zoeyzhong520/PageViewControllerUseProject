//
//  ViewController.swift
//  PageViewControllerUseProject
//
//  Created by zhifu360 on 2019/5/24.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    ///创建UIPageViewController
    lazy var pageController: UIPageViewController = {
        let page = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing: 20])
        page.delegate = self
        page.dataSource = self
        page.setViewControllers([self.dataArray.first!], direction: .forward, animated: true, completion: nil)
        page.view.frame = view.frame
        return page
    }()
    
    var currentIndex: Int = 0
    
    lazy var dataArray: [WebViewController] = {
        var tmpArr = [WebViewController]()
        for i in 0..<6 {
            tmpArr.append(WebViewController())
        }
        return tmpArr
    }()
    
    //滑动完成前的VC
    var previousVC: WebViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
        requestAPI()
    }

    func setPage() {
        title = "演示"
        addChild(pageController)
        view.addSubview(pageController.view)
    }
    
    func requestAPI() {
        let first = dataArray.first
        first?.centerView.image = UIImage(named: "1.jpg")
        dataArray.removeFirst()
        dataArray.insert(first!, at: 0)
    }

}

extension ViewController: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let after = currentIndex + 1
        if after >= dataArray.count {
            return nil
        }
        return dataArray[after]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let before = currentIndex - 1
        if before < 0 {
            return nil
        }
        return dataArray[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        //动画开始前
        print("动画开始前")
        if let vc = pendingViewControllers.first as? WebViewController {
            previousVC = vc
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //动画完成后
        print("动画完成后")
        for item in dataArray.enumerated() {
            if item.element == previousVC {
                currentIndex = item.offset
                //更新WebViewController
                let webVC = dataArray[currentIndex]
                webVC.centerView.image = UIImage(named: "\(currentIndex+1).jpg")
                break
            }
        }
    }
    
}

