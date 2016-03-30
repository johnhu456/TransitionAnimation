//
//  MoveAnimation.swift
//  AnimationOfCollectionView
//
//  Created by MADAO on 16/3/29.
//  Copyright © 2016年 MADAO. All rights reserved.
//

import UIKit

class MoveAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DetailViewController
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let containView = transitionContext.containerView()
        
        //获取当前点击的Cell
        let indexPath = fromViewController.collectionView.indexPathsForSelectedItems()![0]
        let cell = fromViewController.collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell
        //制作截图
        let snapShotView = cell.imageView .snapshotViewAfterScreenUpdates(false)
        
        //注意添加的先后顺序，否则会被遮挡。
        containView?.addSubview((toViewController.view)!)
        containView?.addSubview(snapShotView)
        
        //截图在ContainView中的初始位置调整
        snapShotView.frame = (cell.convertRect(cell.imageView.frame, toView: cell.superview!.superview))
        snapShotView.frame = CGRectMake(snapShotView.frame.origin.x, snapShotView.frame.origin.y + 64, snapShotView.frame.size.width, snapShotView.frame.size.height)

        //对变换前后的原视图进行隐藏
        cell.imageView.hidden = true
        toViewController.detailImageView.hidden = true
        
        //设置第二个控制器位置，透明度
        toViewController.view.frame = transitionContext .finalFrameForViewController(toViewController)
        toViewController.view.alpha = 0
    

        //动画
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveLinear, animations: {
            toViewController.view.alpha = 1
            //假装把Cell的ImageView移动到第二个VC中的ImageView的位置。
            snapShotView.frame = (toViewController.view?.convertRect(toViewController.detailImageView.frame, toView: toViewController.view.superview))!
            
            }) { (success) in
                toViewController.detailImageView.hidden = false;
                cell.imageView.hidden = false;
                //删除截图
                snapShotView.removeFromSuperview()
                //完成动画
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
