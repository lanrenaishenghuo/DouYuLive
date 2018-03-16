//
//  HomeViewController.swift
//  DouYLive
//
//  Created by 东亨 on 2018/3/15.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit
private let KTitleH:CGFloat = 40

class HomeViewController: UIViewController {
    //MARX:- 懒加载属性 通过闭包的形式
    private lazy var pageTitleView:PageTitleView = {
      let titleFrame = CGRect(x:0.0, y: KStatuesBarH+KNavigationBarH, width:KScreenW, height:KTitleH)
      let titles = ["推荐","游戏","娱乐","趣玩"]
      let titleView = PageTitleView(frame: titleFrame, titles: titles)
      return titleView
    }()
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
        view.addSubview(pageTitleView)
    }
    private func setupNavgationBar(){

        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        let btn = UIButton()
        btn.setImage(UIImage(named:"homeLogoIcon"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "btn_disable_gift_normal",size:size)
        let searchItem = UIBarButtonItem(imageName: "home_newSeacrhcon",size:size)
        let qrcodeItem = UIBarButtonItem(imageName: "home_newSaoicon",size:size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
        
    }
}
