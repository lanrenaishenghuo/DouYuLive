//
//  HomeViewController.swift
//  DouYLive
//
//  Created by 东亨 on 2018/3/15.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}
   // 设置ui界面
extension HomeViewController{
    private func setupUI(){
        //1.设置导航栏
        setupNavgationBar()
    }
    private func setupNavgationBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named:""), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
}
