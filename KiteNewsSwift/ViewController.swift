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
    @IBOutlet weak var tfAccount:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    
    @IBAction func onLogin(){
        intoMainViewController()
    }
    @IBAction func onSignUp()
    {
        
        createTableorSave(tfAccount.text!,password: tfPassword.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func createTableorSave(name:String,password:String)
    {
        let kiteNewsUser=BmobObject(className: "kiteNewsUser")
        kiteNewsUser.setObject(name, forKey: "user_name")
        kiteNewsUser.setObject(password, forKey: "user_password")
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
    
    func queryUserNameAndPassword()
    {
        let query:BmobQuery=BmobUser.query()
        
    }
    
    func intoMainViewController()
    {
        let myStoryBoard=self.storyboard
        let mainViewController:UIViewController=myStoryBoard!.instantiateViewControllerWithIdentifier("main_view") as UIViewController
        self.presentViewController(mainViewController, animated: true, completion: nil)
        
    }
}

