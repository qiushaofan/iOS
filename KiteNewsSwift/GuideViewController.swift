//
//  GuideViewController.swift
//  KiteNewsSwift
//
//  Created by 邱少藩 on 16/7/4.
//  Copyright © 2016年 邱少藩. All rights reserved.
//

import UIKit

class GuideViewController:UICollectionViewController {

    let courses=[
      ["name":"Swift","pic":"test_1.png"],
        ["name":"OC","pic":"test_2.png"],
        ["name":"java","pic":"test_3.png"],
        ["name":"php","pic":"test_4.png"]
    ]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor=UIColor.whiteColor()
    }
   
    //实现UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        //返回记录数
        return courses.count;
    }
    
      //实现UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let identify:String="DesignViewCell"
        let cell=(self.collectionView?.dequeueReusableCellWithReuseIdentifier(identify, forIndexPath: indexPath))! as UICollectionViewCell
        (cell.contentView.viewWithTag(1) as! UIImageView).image=UIImage(named: courses[indexPath.item]["pic"]!)
        (cell.contentView.viewWithTag(2) as! UILabel).text=courses[indexPath.item]["name"]!
        
        return cell;
    }
    
    //实现UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        //某个Cell被选择的事件处理
    }
}
