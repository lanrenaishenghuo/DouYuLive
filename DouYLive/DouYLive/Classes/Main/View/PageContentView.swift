//
//  PageContentView.swift
//  DouYLive
//
//  Created by 东亨 on 2018/3/16.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit
private let ContentCellId = "ContentCellId"

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView,progress : CGFloat,sourceIndex:Int,targetIndex:Int)
}

class PageContentView: UIView {

    //MARX:- 创建属性
    private var  childVcs:[UIViewController]
    private weak var parentViewController:UIViewController?
    private var  startOffsetX:CGFloat = 0
    
    weak var delegate : PageContentViewDelegate?
    //闭包相当于oc中的block
    private lazy var collectionView:UICollectionView = { [weak self] in
        //1.创建layout
       let layout = UICollectionViewFlowLayout()
       layout.itemSize = (self?.bounds.size)!
       layout.minimumLineSpacing = 0
       layout.minimumInteritemSpacing = 0
       layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        return collectionView
    }()
    //MARX:- 自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController], parentViewController:UIViewController?) {
        
        self.childVcs = childVcs;
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARX:- 设置UI界面
extension PageContentView{
    //1.将所有的子控制器添加到父控制器中
    private func setupUI(){
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        //添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
//MARX:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let  childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
//MARX:-遵守UICOllectionViewDelegate
extension PageContentView : UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX =  scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{//左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW)
            //2.计算souceIndex
            sourceIndex = Int(currentOffsetX/scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //4. 如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW))
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
        }
        //3. 蒋
        delegate!.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

//向外接提供方法
extension PageContentView{
    func setCurrentIndex(currentIndex : Int){
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offSetX, y : 0), animated: false)
    }
}
