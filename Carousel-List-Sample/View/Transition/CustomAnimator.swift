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
    let textFrame: CGRect
    var image: UIImage?
    var text: String?
    init(imageFrame: CGRect, textFrame: CGRect, image: UIImage?, text: String?) {
        self.imageFrame = imageFrame
        self.textFrame = textFrame
        self.image = image
        self.text = text
    }
}

protocol TransitionType {
    var shopImageView: UIImageView! { get }
    var shopNameTextView: UITextView! { get }
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
            let imageView = destinationVC.shopImageView, let textView = destinationVC.shopNameTextView else {
                return
        }
        
        imageView.image = objectData.image
        textView.text = objectData.text
        imageView.alpha = 0
        textView.alpha = 0
        
        // 移動中下を見せたくないため
        let whiteViewForImage = UIView(frame: objectData.imageFrame)
        whiteViewForImage.backgroundColor = .white
        container.addSubview(whiteViewForImage)
        let whiteViewForText = UIView(frame: objectData.textFrame)
        whiteViewForText.backgroundColor = .white
        container.addSubview(whiteViewForText)
        
        let transitionImageView = UIImageView(frame: isPresenting ? objectData.imageFrame : imageView.frame)
        transitionImageView.image = objectData.image
        transitionImageView.layer.masksToBounds = true
        container.addSubview(transitionImageView)
        let transitionText = UITextView(frame: isPresenting ? objectData.textFrame : textView.frame)
        transitionText.backgroundColor = .clear
        transitionText.text = objectData.text
        container.addSubview(transitionText)
        
        toView.frame = isPresenting ? CGRect(x: fromView.frame.width,
                                             y: 0,
                                             width: toView.frame.width,
                                             height: toView.frame.height) : toView.frame
        
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        detailView.frame = self.isPresenting ? fromView.frame : toView.frame
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? imageView.frame : self.objectData.imageFrame
            transitionImageView.layer.cornerRadius = self.isPresenting ? 0 : 10
            transitionText.frame = self.isPresenting ? textView.frame : self.objectData.textFrame
            self.isPresenting ? transitionText.adjustFontForDetailView() : transitionText.adjustFontForListView()
            detailView.alpha = self.isPresenting ? 1 : 0
            // whiteViewが遷移後画面で悪さをする問題の対応
            if self.isPresenting {
                whiteViewForImage.alpha = 0.3
                whiteViewForText.alpha = 0.3
            }
        }, completion: { finished in
            imageView.alpha = 1
            textView.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            whiteViewForImage.removeFromSuperview()
            whiteViewForText.removeFromSuperview()
            transitionImageView.removeFromSuperview()
            transitionText.removeFromSuperview()
        })
    }
}
