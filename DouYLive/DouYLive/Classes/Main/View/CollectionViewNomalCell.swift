//
//  CollectionViewNomalCell.swift
//  DouYLive
//
//  Created by 东亨 on 2018/4/9.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewNomalCell: UICollectionViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImg.kf.setImage(with:URL(string:"http://img.zcool.cn/community/01314e58ec3de2a8012049ef73a8fa.jpg"))
    }
}
