//
//  PageTitleView.swift
//  DouYLive
//
//  Created by 东亨 on 2018/3/16.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func PageTitleViewIndex(titleView : PageTitleView, selectedIndex index : Int)
}

private let KScrollLineH:CGFloat = 2
private let KNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let KSelectColor:(CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    private var currentIndex:NSInteger = 0
    //MARX:- 定义属性
    private var titles: [String]
    
    weak var delegate : PageTitleViewDelegate?
    
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
            lable.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
            lable.textAlignment = .center
            
            //3. 设置lable 的frame
            let lableX:CGFloat = lableW * CGFloat(index)
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            //4.将lable 添加到scrollerView
            scrollView.addSubview(lable)
            titleLables.append(lable)
            //给lable 添加属性
            let tapGes = UITapGestureRecognizer(target: self,action:#selector(self.titleLableClick(tapGes:)))
            lable.addGestureRecognizer(tapGes)
            lable.isUserInteractionEnabled = true
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
        firstLable.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        scrollerLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - KScrollLineH, width: firstLable.frame.size.width, height: KScrollLineH)
    }
    
}
//MARX:-监听手势
extension PageTitleView{
    @objc private  func titleLableClick(tapGes:UITapGestureRecognizer){
        //1.获取当前Lable
        guard let currentLable = tapGes.view as? UILabel  else{return}
        //2.获取之前Lable
        let oldLable = titleLables[currentIndex]
        //3. 切换文字的颜色
        currentLable.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        oldLable.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
        
        currentIndex  = currentLable.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLable.tag) * scrollerLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollerLine.frame.origin.x = scrollLineX
        }
        //6.通知代理
        delegate?.PageTitleViewIndex(titleView: self, selectedIndex: currentIndex)
    }
}
extension PageTitleView{
    func setTitleWithProgress(progress : CGFloat,sourceIndex:Int,targetIndex:Int){
        //1.取出sourceLable/targetLable
        
        let  sourceLable = titleLables[sourceIndex]
        let  targetLable = titleLables[targetIndex]
        
        let  moveToTalX = targetLable.frame.origin.x - sourceLable.frame.origin.x
        let moveX = moveToTalX * progress
        scrollerLine.frame.origin.x = sourceLable.frame.origin.x + moveX
        //3 颜色发生渐变
        let colorDelta  = (KSelectColor.0 - KNormalColor.0,KSelectColor.1 - KNormalColor.1,KSelectColor.2 - KNormalColor.2)
        
        //3.2变化souceLable
        sourceLable.textColor = UIColor(r: KSelectColor.0 - colorDelta.0*progress, g: KSelectColor.1 - colorDelta.1*progress, b: KSelectColor.2 - colorDelta.2*progress)
        
        targetLable.textColor = UIColor(r: KNormalColor.0+colorDelta.0*progress, g: KNormalColor.1+colorDelta.1*progress, b: KNormalColor.2+colorDelta.2*progress)
        
    }
}
