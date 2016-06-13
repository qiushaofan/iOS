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
    var soucreImage:UIImage!
    
    /* 覆盖图片 */
    var coverImage:UIImage!
    
    
    var sourceImageView:UIImageView!
    var coverImageView:UIImageView!
    
    var boderLayer:CALayer!  //框架层
    var shapeLayer:CAShapeLayer!  //路径层
    var path:CGMutablePathRef!//路径层的路径
    
    override init(frame: CGRect) {
        super.init(frame: <#T##CGRect#>)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
