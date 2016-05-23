//
//  MyCollectionCell.swift
//  KiteNewsSwift
//
//  Created by 邱少藩 on 16/5/23.
//  Copyright © 2016年 邱少藩. All rights reserved.
//

import UIKit

class MyCollectionCell:UICollectionViewCell
{
   @IBOutlet var imageview:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds=true
        self.layer.cornerRadius=4
    }
}
