//
//  PageTitleView.swift
//  DouYLive
//
//  Created by 东亨 on 2018/3/16.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit
private let KScrollLineH:CGFloat = 2

class PageTitleView: UIView {
    
    //MARX:- 定义属性
    private var titles: [String]
    private lazy var titleLables : [UILabel] = [UILabel]()
    //MARX:- 懒加载属性 通过闭包的形式创建
    private lazy var scrollView: UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.scrollsToTop = false
        scrollerView.bounces = false
        return scrollerView;
    }()
    private lazy var scrollerLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    
    //MARX：- 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageTitleView {

    private func setupUI(){
        //1. 添加UIScrollerView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2. 添加title对应的Lable
        setTitleLable()
        //3. 设置底线和滚动条
        setupBottomLineAndScrollLine()
    }
    private func setTitleLable(){
        let lableW:CGFloat = frame.width / CGFloat(titles.count)
        let lableH:CGFloat = frame.height - KScrollLineH
        let lableY:CGFloat = 0
        for (index ,title) in titles.enumerated() {
            //1.创建UIlable
            let lable = UILabel()
            
            //2.设置lable 的属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            
            //3. 设置lable 的frame
            let lableX:CGFloat = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            //4.将lable 添加到scrollerView
            scrollView.addSubview(lable)
            titleLables.append(lable)
        }
    }
    private func setupBottomLineAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //2. 添加scrollerLine
        scrollView.addSubview(scrollerLine)
        guard let firstLable = titleLables.first else {
            return
        }
        scrollerLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - KScrollLineH, width: firstLable.frame.size.width, height: KScrollLineH)
    }
}
