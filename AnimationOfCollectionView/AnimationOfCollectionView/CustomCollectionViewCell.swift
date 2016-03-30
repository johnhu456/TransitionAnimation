//
//  CustomCollectionViewCell.swift
//  AnimationOfCollectionView
//
//  Created by MADAO on 16/3/29.
//  Copyright © 2016年 MADAO. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    var dataModel:CustomModel?{
        willSet{
            self.imageView.image = UIImage(named: (newValue?.imageName)!)
            self.lblTitle.text = newValue?.title
        }
    }
}
