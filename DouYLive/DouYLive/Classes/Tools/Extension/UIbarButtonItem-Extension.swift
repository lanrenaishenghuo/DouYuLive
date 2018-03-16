//
//  UIbarButtonItem-Extension.swift
//  DouYLive
//
//  Created by 东亨 on 2018/3/16.
//  Copyright © 2018年 lichao. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //类方法
    /*
    class func createItem(imageName:String,highImageName:String,size:CGSize)->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        btn.frame = CGRect(origin:CGPoint(x: 0, y: 0) , size: size)
        
        return UIBarButtonItem(customView: btn)
    }
 */
    //便利构造函数：1> convenience 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName:String = "",highImageName:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin:CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
