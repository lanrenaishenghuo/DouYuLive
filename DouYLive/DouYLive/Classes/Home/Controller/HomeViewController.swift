//
//  HomeViewController.swift
//  DouYLive
//
//  Created by 东亨 on 2018/3/15.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit
private let KTitleViewH:CGFloat = 40

class HomeViewController: UIViewController {
    //MARX:- 懒加载属性 通过闭包的形式
    private lazy var pageTitleView:PageTitleView = {[weak self] in
      let titleFrame = CGRect(x: 0, y: KStatuesBarH+KNavigationBarH, width:KScreenW, height:KTitleViewH)
      let titles = ["推荐","游戏","娱乐","趣玩"]
      let titleView = PageTitleView(frame: titleFrame, titles: titles)
      titleView.delegate = self
      return titleView
    }()
    
    private lazy var pageContentView:PageContentView = {[weak self] in
        //1.确定内容的frame
        let contentH = KScreenH - KStatuesBarH - KNavigationBarH - KTitleViewH - KTabbarH
        let contentFrame = CGRect(x: 0, y: KStatuesBarH + KNavigationBarH + KTitleViewH, width: KScreenW, height: contentH)
        //2 确定所有的自控制器
        var childVcs = [UIViewController]()
        childVcs .append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r:CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs:childVcs, parentViewController:self)
        contentView.delegate = self
        return contentView
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
        //2.添加titleView
        view.addSubview(pageTitleView)
        //3.添加contentView
        view.addSubview(pageContentView)
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
extension HomeViewController : PageTitleViewDelegate{
    func PageTitleViewIndex(titleView: PageTitleView, selectedIndex index: Int) {
          pageContentView.setCurrentIndex(currentIndex: index)
    }
}
extension HomeViewController: PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
       pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

