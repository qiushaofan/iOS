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
    var sdCycleScrollView2:SDCycleScrollView!
    @IBOutlet weak var scrollview:UIScrollView!
    
    let imageArray:NSArray! = ["wallpaper_cat.jpg","wallpaper_mom.jpg","wallpaper_tree.jpg"]
    
    let urlImageArray:NSArray! = [
        "http://www.henansc.com/uploadfile/2015/0210/20150210104804382.jpg",
        
        "http://www.henansc.com/uploadfile/2015/0212/20150212081452412.jpg",
        
        "http://www.henansc.com/uploadfile/2015/0212/20150212081841462.jpg",
        
        "http://www.henansc.com/uploadfile/2015/0210/20150210110611181.jpg",
        
        "http://www.henansc.com/uploadfile/2015/0210/20150210105956264.jpg"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let frame:CGRect! = CGRect.init(x: 0, y: 20, width: UIScreen.mainScreen().bounds.width, height: 200)
        let frame1:CGRect! = CGRect.init(x: 0, y: 230, width: UIScreen.mainScreen().bounds.width, height: 200)
        
        sdCycleScrollView = SDCycleScrollView.init(frame: frame, imageNamesGroup: imageArray as [AnyObject])
        sdCycleScrollView2=SDCycleScrollView.init(frame: frame1, imageURLStringsGroup: urlImageArray as [AnyObject])
        sdCycleScrollView.delegate=self
        self.view.addSubview(sdCycleScrollView)
        self.view.addSubview(sdCycleScrollView2)
        
        
        
//        ImageLoader.sharedLoader.imageForUrl(urlImageArray[0] as! String, completionHandler:{(image:UIImage?,url:String) in
//            let imageView:UIImageView!=UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 400))
//            imageView.image=image
//            self.scrollview.addSubview(imageView)
//            
//            
//            //self.scrollview.bounces=false
//            self.scrollview.contentSize=CGSize.init(width: 1000, height: 2000)
//            self.scrollview.contentOffset = CGPoint(x: 0, y: 0)
//        })
        
        ImageLoader.sharedLoader.imageForUrls(urlImageArray as NSArray, completionHandler:{(image:UIImage?,url:String,index:Int) in
            let xValue:CGFloat = 400 * CGFloat(Float(index))
            let yValue:CGFloat = 400 * CGFloat(Float(index))
            
            let imageView:UIImageView!=UIImageView.init(frame: CGRect.init(x: 0, y: yValue, width: UIScreen.mainScreen().bounds.width, height: 400))
            imageView.image=image
            self.scrollview.addSubview(imageView)
            
            
            //self.scrollview.bounces=false
        })
        
        self.scrollview.contentSize=CGSize.init(width: UIScreen.mainScreen().bounds.width.hashValue, height: 400*urlImageArray.count)
        self.scrollview.contentOffset = CGPoint(x: 0, y: 0)
        
        
    }
    
    func scrollViewCanScroll()
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intoNextViewController()
    {
        let myStoryBoard:UIStoryboard!=self.storyboard
        let mainViewController:UIViewController=myStoryBoard.instantiateViewControllerWithIdentifier("flow_view") as UIViewController
        self.presentViewController(mainViewController, animated: true, completion: nil)
        
    }
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        intoNextViewController();
    }
    
}

