//
//  WebViewController.swift
//  PageViewControllerUseProject
//
//  Created by zhifu360 on 2019/5/24.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {

    ///创建UIImageView
    lazy var centerView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.center = self.view.center
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    func setPage() {
        view.addSubview(centerView)
    }

}
