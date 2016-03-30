//
//  CustomModel.swift
//  AnimationOfCollectionView
//
//  Created by MADAO on 16/3/29.
//  Copyright © 2016年 MADAO. All rights reserved.
//

import UIKit

class CustomModel: NSObject {

    var imageName: String?
    var title: String?
    var brief: String?
    
    init(image:String?,title:String?,brief:String?) {
        self.imageName = image
        self.title = title
        self.brief = brief

    }
    
    static func getDemoData() -> [CustomModel]{
        return [CustomModel(image: "1", title: "DIVE", brief:"sdfjkhkjfdhfjkshfklsjflkdshfklsdfklsdjfklsdjfklsjfkl"),
        
                CustomModel(image: "2", title: "WATER", brief:"sdfjkhkjfdhfjkshfklsjflkdshfklsdfklsdjfklsdjfklsjfkl"),
        
               CustomModel(image: "3", title: "BEACH", brief:"sdfjkhkjfdhfjkshfklsjflkdshfklsdfklsdjfklsdjfklsjfkl"),
               
               CustomModel(image: "4", title: "FIREWORK", brief:"sdfjkhkjfdhfjkshfklsjflkdshfklsdfklsdjfklsdjfklsjfkl"),
               
               CustomModel(image: "5", title: "MOUTAIN", brief:"sdfjkhkjfdhfjkshfklsjflkdshfklsdfklsdjfklsdjfklsjfkl"),
        ]
    }
}
