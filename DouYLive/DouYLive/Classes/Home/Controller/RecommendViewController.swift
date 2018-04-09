//
//  RecommendViewController.swift
//  DouYLive
//
//  Created by 东亨 on 2018/4/9.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit

private let KItemMargin : CGFloat = 10
private let KItemW = (KScreenW - 3*KItemMargin) / 2
private let KItemH  = KItemW*3/4
private let KHeadViewH: CGFloat = 50
private let KFootViewH: CGFloat = 38

private let KNormalCellID = "KNormalCellID"
private let KHeadViewID = "KHeadViewID"
private let KFootViewID = "KFootViewID"

class RecommendViewController: UIViewController {
  //MARX - 系统回调函数
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: KItemW, height: KItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = KItemMargin
        layout.headerReferenceSize = CGSize(width: KScreenW, height: KHeadViewH)
        layout.footerReferenceSize = CGSize(width: KScreenW, height: KFootViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.autoresizingMask  = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName:"CollectionViewNomalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
        
        collectionView.register(UINib(nibName:"CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeadViewID)
        
        collectionView.register(UINib(nibName:"CollectionFootView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: KFootViewID)
        
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
extension RecommendViewController{
    private func setupUI(){
        view .addSubview(collectionView)
    }
}
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind  == UICollectionElementKindSectionHeader {
            //1.获取区头
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeadViewID, for: indexPath)
            return headView;
        }else{
            let footView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KFootViewID, for: indexPath)
            return footView;
            
        }
    }
}
