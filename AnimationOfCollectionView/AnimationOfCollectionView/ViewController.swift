//
//  ViewController.swift
//  AnimationOfCollectionView
//
//  Created by MADAO on 16/3/23.
//  Copyright © 2016年 MADAO. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate {

    var dataArray:[CustomModel]?
    weak var delegate: UINavigationControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = CustomModel.getDemoData()
        self.navigationController?.delegate = self
    }

    //MARK: - UICollectionViewDataSourceAndDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataArray?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("mainCell", forIndexPath: indexPath) as! CustomCollectionViewCell
        collectionCell.dataModel = dataArray![indexPath.row]
        return collectionCell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC = DetailViewController(nibName: "DetailViewController",bundle:NSBundle.mainBundle())
        detailVC.detailModel = dataArray?[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: - Translation
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC.isKindOfClass(DetailViewController)
            //建议对第二个ViewController进行判断，否则pop回来动画混乱，如果有必要还可以对operation进行判断（push or pop）
        {
            //创建一个你刚写的类的对象即可。
            let transition = MoveAnimation()
            return transition
        }
        else{
            return nil
        }

    }
}

