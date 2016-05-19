//
//  ViewController.swift
//  KiteNewsSwift
//
//  Created by 邱少藩 on 16/5/12.
//  Copyright © 2016年 邱少藩. All rights reserved.
//

import UIKit
import SDCycleScrollView

class MainViewController: UIViewController,SDCycleScrollViewDelegate {
    
    var sdCycleScrollView:SDCycleScrollView!
    let imageArray:NSArray! = ["wallpaper_cat.jpg","wallpaper_mom.jpg","wallpaper_tree.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let frame:CGRect! = CGRect.init(x: 0, y: 20, width: UIScreen.mainScreen().bounds.width, height: 200)
        let firstImage:UIImage! = UIImage.init(named: "wallpaper_cat.jpg")
//        sdCycleScrollView = SDCycleScrollView.init(frame: frame, delegate: self, placeholderImage: firstImage)
        sdCycleScrollView=SDCycleScrollView.init(frame: frame, imageNamesGroup: imageArray as [AnyObject])
        
        self.view.addSubview(sdCycleScrollView)
        //        let imageView=UIImageView(image:UIImage(named:"wallpaper_cat.jpg"))
        //        imageView.frame=CGRectMake(10,10,100,100)
        //        self.view.addSubview(imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

