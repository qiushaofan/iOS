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

    var layout:MyLayout?
    var testImgArr=[Int]()
    var mycollectionview:UICollectionView?
    var content_y=CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTestInfo()
        //
        layout = MyLayout()
        layout!.delegate = self
        
        let cellNib:UINib = UINib(nibName: "MyCollectionCell", bundle: nil)
        
        //mycollectionview
        mycollectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout!)
        mycollectionview!.delegate = self
        mycollectionview!.dataSource = self
        mycollectionview!.backgroundColor = UIColor.clearColor()
        mycollectionview!.registerNib(cellNib, forCellWithReuseIdentifier: "MyCollectionCell")
        self.view.addSubview(mycollectionview!)
        
        
        
        //play
        print(NSInteger.max, terminator: "")

        
    }
    //设置测试数据
    func getTestInfo(){
        
        //
        //在取随机14张图片 1~16 包括1 不包括16
        testImgArr = createGenerator(13)(1,16)
        
        print(testImgArr, terminator: "")
        
        
    }
    //返回一个随机不重复数组
    func createGenerator(count:Int)->(Int,Int)->[Int]{
        
        //http://stackoverflow.com/questions/24270693/nested-recursive-function-in-swift
        var generator:(Int,Int)->[Int] = {_,_ in return []} // give it a no-op definition
        var total = count
        generator = {min,max in
            if (total <= 0 || min>max) {
                return []
            }else{
                total -= 1;
                let random = Int(arc4random_uniform(UInt32(max-min)))
                let mid = min + random
                return [mid]+generator(min, mid-1)+generator(mid+1, max)
            }
        }
        
        return generator
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
