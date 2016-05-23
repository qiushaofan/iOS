//
//  FlowVIew.swift
//  KiteNewsSwift
//
//  Created by 邱少藩 on 16/5/23.
//  Copyright © 2016年 邱少藩. All rights reserved.
//

import UIKit

class FlowView:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
               ,WaterFlayoutDelegate,LSImgZoomViewDelegate
{

    var myLayout:MyLayout?
    var testImgArr=[Int]()
    var myCollectionView:UICollectionView?
    var content_y=CGFloat()

    override func viewDidLoad() {
        
    }
    
    //WaterFlayoutDelegate
    func collectionView(collectionview: UICollectionView, layout: UICollectionViewLayout, indexPath: NSIndexPath) -> CGSize {
        //
        let item_w = (collectionview.frame.size.width-24)*0.5
        
        //对应图片下标
        let imgIndex = testImgArr[indexPath.row]
        
        //取出当前图片
        let item_img = UIImage(named: NSString(format: "test_%d.png",imgIndex) as String)
        
        let imgsize = item_img!.size
        let img_h =  (imgsize.height*item_w)/imgsize.width
        
        return CGSizeMake(item_w, img_h)
    }
    
    //UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return testImgArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCollectionCell", forIndexPath: indexPath) as! MyCollectionCell
        
        //对应图片下标
        let imgIndex = testImgArr[indexPath.row]
        
        //取出当前图片
        let item_img = UIImage(named: NSString(format: "test_%d.png",imgIndex) as String)
        
        cell.imageview.image = item_img
        
        return cell
    }
    
    
    
    //UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MyCollectionCell
        cell.imageview.hidden = true
        
        var baseframe = CGRectMake(cell.frame.origin.x, cell.frame.origin.y-content_y, cell.frame.size.width, cell.frame.size.height)
        
        var zoomv = LSImgZoomView(baseframe: baseframe)
        zoomv.delegate = self
        zoomv.setCurrImg(cell.imageview.image!)
        zoomv.show()
        
        zoomv.blockClose = {(done:Bool) -> Void in
            //
            cell.imageview.hidden = false
        }
    }
    
    //LSImgZoomViewDelegate
    func lsImgZoomView(close: Bool) {
        //
        if (close){
            
        }
    }
    

}
