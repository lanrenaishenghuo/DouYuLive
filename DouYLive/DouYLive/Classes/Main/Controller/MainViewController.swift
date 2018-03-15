//
//  MainViewController.swift
//  DouYLive
//
//  Created by 东亨 on 2018/3/15.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storeName: "Home")
        addChildVc(storeName: "Live")
        addChildVc(storeName: "Folow")
        addChildVc(storeName: "Profile")
    }
    private func addChildVc(storeName:String){
        //将可选类型，解包成固定类型
        let childVc = UIStoryboard(name:storeName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }
}
