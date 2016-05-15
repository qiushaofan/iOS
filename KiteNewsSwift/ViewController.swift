//
//  ViewController.swift
//  KiteNewsSwift
//
//  Created by 邱少藩 on 16/5/12.
//  Copyright © 2016年 邱少藩. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var btnLogin:UIButton!
    @IBAction func onLogin(){
        
       btnLogin.backgroundColor=UIColor.redColor()
       createTableorSave()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func createTableorSave()
    {
        let kiteNewsUser=BmobObject(className: "kiteNewsUser")
        kiteNewsUser.setObject("name", forKey: "user_name")
        kiteNewsUser.setObject("12", forKey: "age")
        kiteNewsUser.setObject("8888", forKey: "user_password")
        kiteNewsUser.saveInBackgroundWithResultBlock{(isSuccessful,error) in
           if error != nil
           {
               print("Fail")
            }
            else
           {
               print("Successful")
            }
        }
        
    }
}

