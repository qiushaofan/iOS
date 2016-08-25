//
//  ScartchView.swift
//  KiteNewsSwift
//
//  Created by 邱少藩 on 16/6/13.
//  Copyright © 2016年 邱少藩. All rights reserved.
//

import UIKit

class ScartchView:UIView{

    /* 原始图片 */
    var sourceImage:UIImage!
    
    /* 覆盖图片 */
    var coverImage:UIImage!
    
    
    var sourceImageView:UIImageView!
    var coverImageView:UIImageView!
    
    var boderLayer:CALayer!  //框架层
    var shapeLayer:CAShapeLayer!  //路径层
    var path:CGMutablePathRef!//路径层的路径
    
    var isOpen:Bool=false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sourceImageView=UIImageView.init(frame: self.bounds)
        self.addSubview(sourceImageView)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
