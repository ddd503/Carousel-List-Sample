//
//  CustomAnimator.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/11.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

struct TappedObjectData {
    let imageFrame: CGRect
    let labelFrame: CGRect
    var image: UIImage?
    var text: String?
    init(imageFrame: CGRect, labelFrame: CGRect, image: UIImage?, text: String?) {
        self.imageFrame = imageFrame
        self.labelFrame = labelFrame
        self.image = image
        self.text = text
    }
}

protocol TransitionType {
    var shopImageView: UIImageView! { get }
    var shopNameLabel: UILabel! { get }
}

final class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval
    var isPresenting: Bool
    var objectData: TappedObjectData
    
    init(duration : TimeInterval, isPresenting : Bool, objectData: TappedObjectData) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.objectData = objectData
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        detailView.alpha = 0
        
        guard let destinationVC = isPresenting ?
            transitionContext.viewController(forKey: .to) as? TransitionType :
            transitionContext.viewController(forKey: .from) as? TransitionType,
            let imageView = destinationVC.shopImageView, let label = destinationVC.shopNameLabel else {
                return
        }
        
        imageView.image = objectData.image
        label.text = objectData.text
        imageView.alpha = 0
        label.alpha = 0
        
        // 移動中下を見せたくないため
        let whiteViewForImage = UIView(frame: objectData.imageFrame)
        whiteViewForImage.backgroundColor = .white
        container.addSubview(whiteViewForImage)
        let whiteViewForLabel = UIView(frame: objectData.labelFrame)
        whiteViewForLabel.backgroundColor = .white
        container.addSubview(whiteViewForLabel)
        
        let transitionImageView = UIImageView(frame: isPresenting ? objectData.imageFrame : imageView.frame)
        transitionImageView.image = objectData.image
        container.addSubview(transitionImageView)
        let transitionLabel = UILabel(frame: isPresenting ? objectData.labelFrame : label.frame)
        transitionLabel.text = objectData.text
        container.addSubview(transitionLabel)
        
        toView.frame = isPresenting ? CGRect(x: fromView.frame.width,
                                             y: 0,
                                             width: toView.frame.width,
                                             height: toView.frame.height) : toView.frame
        
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        detailView.frame = self.isPresenting ? fromView.frame : toView.frame
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? imageView.frame : self.objectData.imageFrame
            transitionLabel.frame = self.isPresenting ? label.frame : self.objectData.labelFrame
            detailView.alpha = self.isPresenting ? 1 : 0
            // whiteViewが遷移後画面で悪さをする問題の対応
            if self.isPresenting {
                whiteViewForImage.alpha = 0.3
                whiteViewForLabel.alpha = 0.3
            }
        }, completion: { finished in
            imageView.alpha = 1
            label.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            whiteViewForImage.removeFromSuperview()
            whiteViewForLabel.removeFromSuperview()
            transitionImageView.removeFromSuperview()
            transitionLabel.removeFromSuperview()
        })
    }
}
