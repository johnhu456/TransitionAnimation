//
//  DetailViewController.swift
//  AnimationOfCollectionView
//
//  Created by MADAO on 16/3/29.
//  Copyright © 2016年 MADAO. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailTitle: UILabel!
    
    @IBOutlet weak var detailBrief: UITextView!
    
    var detailModel:CustomModel?
    
    var percentTransition:UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = UIImage(named: (detailModel!.imageName)!)
        detailTitle.text = detailModel!.title
        detailBrief.text = detailModel!.brief
        
        self.setupGestureRecognizer()
        self.navigationController?.delegate = self
    }

    func setupGestureRecognizer() {
        //设置边缘触控手势及其方位
        let edgeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self,action: #selector(DetailViewController.edgePanGesture(_:)))
        edgeGestureRecognizer.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(edgeGestureRecognizer)
    }
    
    func edgePanGesture(gestureRecognizer:UIScreenEdgePanGestureRecognizer) {
        //计算动画完成度Progress
        var progress = gestureRecognizer.translationInView(self.view).x/self.view.frame.size.width
        progress = min(1.0, max(0.0, progress))
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began{
            //手势开始，执行Pop动作，触发动画
            percentTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Changed{
            //手势执行过程中，不停通过progress去更新动画状态
            percentTransition?.updateInteractiveTransition(progress)
        }
        else if gestureRecognizer.state == UIGestureRecognizerState.Cancelled || gestureRecognizer.state == UIGestureRecognizerState.Ended {
            //手势取消或者结束，判断是否完成动画或者取消。
            if progress > 0.1
            {
                percentTransition?.finishInteractiveTransition()
            }
            else
            {
                percentTransition?.cancelInteractiveTransition()
            }
        }
        
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC.isKindOfClass(ViewController)
        {
            return MoveInverseTransition()
        }
        else{
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController.isKindOfClass(MoveInverseTransition)
        {
            return percentTransition
        }
        else
        {
            return nil
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
