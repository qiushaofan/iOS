//
//  MyLayout.swift
//  LSFlowView
//
//  Created by  tsou117 on 15/7/6.
//  Copyright (c) 2015年  tsou117. All rights reserved.
//

import Foundation
import UIKit


protocol WaterFlayoutDelegate{
    
    func collectionView(collectionview:UICollectionView,layout:UICollectionViewLayout,indexPath:NSIndexPath) ->CGSize
    
}
//声明一个继承与UICollectionViewLayout的类，等待后面调用
//此类所做的是定义了CollectionView的布局
class MyLayout: UICollectionViewLayout {
    //
    var delegate:WaterFlayoutDelegate?
    
    //
    
    var x = CGFloat()
    var leftY = CGFloat()
    var rightY = CGFloat()
    var YY = CGFloat()
    //
    var itemwidth = CGFloat()
    var center = CGPoint()
    var radius = CGFloat()
    var itemcount = NSInteger()
    let sectionInset = UIEdgeInsets(top: 8,left: 8,bottom: 8,right: 8)
    
    
    override func prepareLayout() {
        //
        super.prepareLayout()
        
        let size = self.collectionView!.frame.size  //size 为view的框架尺寸
        self.itemwidth = (size.width-24)/2 //每个item的宽度
        
        // as WaterFlayoutDelegate 在协议protocol前面需要加上@objc，不加也行
        self.delegate = self.collectionView!.delegate as! WaterFlayoutDelegate?
        
        
        itemcount = self.collectionView!.numberOfItemsInSection(0)
        center = CGPointMake(size.width*0.5, size.height*0.5)
        radius = min(size.width, size.height)/2.5  //我的理解应该是矩形的圆弧角，但好像没用到
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        let nowH = leftY > rightY ? leftY : rightY
        
        return CGSizeMake(self.collectionView!.frame.size.width, nowH)
    }
    
    
    func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath,index:NSInteger) -> UICollectionViewLayoutAttributes! {
        //
        let itemsize = self.delegate?.collectionView(self.collectionView!, layout: self, indexPath: indexPath)
        let itemheight = floor(itemsize!.height*itemwidth/itemsize!.width)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        let nowindex = index + 1
        
        if (nowindex == 1)
        {
            
            x = sectionInset.left
            leftY += sectionInset.top+20
            attributes.frame = CGRectMake(x, leftY, itemwidth, itemheight)
            leftY += itemheight
        }
        else if (nowindex == 2)
        {
            
            x += (itemwidth + sectionInset.left)
            rightY += sectionInset.top+20
            attributes.frame = CGRectMake(x, rightY, itemwidth, itemheight)
            rightY += itemheight
        }
        else if (nowindex%2 == 0){
            //
            x += (itemwidth + sectionInset.left)
            rightY += sectionInset.top
            attributes.frame = CGRectMake(x, rightY, itemwidth, itemheight)
            rightY += itemheight
            
        }else if (nowindex%2 == 1){
            //
            x = sectionInset.left
            leftY += sectionInset.top
            attributes.frame = CGRectMake(x, leftY, itemwidth, itemheight)
            leftY += itemheight
        }
    
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //
        x = 0
        leftY = 0
        rightY = 0
        
        var attributes = [UICollectionViewLayoutAttributes]()
        for i in 0 ..< itemcount{
            let indexpath = NSIndexPath(forItem: i, inSection: 0)
            [attributes.append(layoutAttributesForItemAtIndexPath(indexpath, index: i))];
        }
        
        return attributes
    }
    
    

    
}