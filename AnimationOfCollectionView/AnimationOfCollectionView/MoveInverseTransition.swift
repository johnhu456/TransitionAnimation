//
//  MoveInverseTransition.swift
//  AnimationOfCollectionView
//
//  Created by MADAO on 16/3/29.
//  Copyright © 2016年 MADAO. All rights reserved.
//

import UIKit

class MoveInverseTransition: NSObject,UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! DetailViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        let containView = transitionContext.containerView()
        
        //获取当前点击的Cell
        let indexPath = toViewController.collectionView.indexPathsForSelectedItems()![0]
        let cell = toViewController.collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell
        let snapShotView = fromViewController.detailImageView .snapshotViewAfterScreenUpdates(false)
        containView?.addSubview((toViewController.view)!)
        containView?.addSubview(snapShotView)
        
        snapShotView.frame = (fromViewController.view.convertRect(fromViewController.detailImageView.frame, toView:fromViewController.view.superview))
        cell.imageView.hidden = true
        
        //设置第二个控制器位置，透明度
        toViewController.view.frame = transitionContext .finalFrameForViewController(toViewController)
        toViewController.view.alpha = 0
        
        
        //动画
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions.CurveLinear, animations: {
            toViewController.view.alpha = 1
            snapShotView.frame = (cell.convertRect(cell.imageView.frame, toView:cell.superview?.superview))
            snapShotView.frame = CGRectMake(snapShotView.frame.origin.x, snapShotView.frame.origin.y + 64, snapShotView.frame.size.width, snapShotView.frame.size.height)

        }){ (success) in
            fromViewController.detailImageView.hidden = false;
            cell.imageView.hidden = false;
            snapShotView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }

}

