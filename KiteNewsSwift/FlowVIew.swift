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
    let urlImageArray:NSArray! = [
        "http://www.henansc.com/uploadfile/2015/0210/20150210104804382.jpg",
        
        "http://www.henansc.com/uploadfile/2015/0212/20150212081452412.jpg",
        
        "http://www.henansc.com/uploadfile/2015/0212/20150212081841462.jpg",
        
        "http://www.henansc.com/uploadfile/2015/0210/20150210110611181.jpg",
        
        "http://www.henansc.com/uploadfile/2015/0210/20150210105956264.jpg"
    ]
    
    
    var layout:MyLayout?
    var testImgArr=[Int]()
    var mycollectionview:UICollectionView?
    var content_y=CGFloat()
    var urlImgArr=[UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        ImageLoader.sharedLoader.imageForUrls(urlImageArray as NSArray, completionHandler: {
            (image:UIImage?,url:String,index:Int) in
        
            self.urlImgArr.append(image!)
            
            if index==4
            {
                self.getTestInfo()
                //
                self.layout = MyLayout()
                self.layout!.delegate = self
                
                let cellNib:UINib = UINib(nibName: "MyCollectionCell", bundle: nil)
                
                //mycollectionview
                self.mycollectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.layout!)
                self.mycollectionview!.delegate = self
                self.mycollectionview!.dataSource = self
                self.mycollectionview!.backgroundColor = UIColor.clearColor()
                self.mycollectionview!.registerNib(cellNib, forCellWithReuseIdentifier: "MyCollectionCell")
                self.view.addSubview(self.mycollectionview!)
            }
            
        })
        
        //play
        print(NSInteger.max, terminator: "")

        
    }
    //设置测试数据
    func getTestInfo(){
        
        //
        //在取随机数
        testImgArr = createGenerator(5)(0,4)
        
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
 //       let item_img = UIImage(named: NSString(format: "test_%d.png",imgIndex) as String)
        let item_img = urlImgArr[imgIndex]
        let imgsize = item_img.size
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
 //       let item_img = UIImage(named: NSString(format: "test_%d.png",imgIndex) as String)
        
        let item_img = urlImgArr[imgIndex]
        cell.imageview.image = item_img
        
        return cell
    }
    
    
    
    //UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MyCollectionCell
        cell.imageview.hidden = true
        
        let baseframe = CGRectMake(cell.frame.origin.x, cell.frame.origin.y-content_y, cell.frame.size.width, cell.frame.size.height)
        
        let zoomv = LSImgZoomView(baseframe: baseframe)
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
