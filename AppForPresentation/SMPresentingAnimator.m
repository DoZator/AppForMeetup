//
//  SMPresentingAnimator.m
//
//  Created by Oleg Bogatenko on 8/5/14.
//  Copyright (c) 2014 intelex LLC. All rights reserved.
//

#import "SMPresentingAnimator.h"
#import <pop/POP.h>

@implementation SMPresentingAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 1024.f, 1024.f)];
    
    dimmingView.backgroundColor = [UIColor colorWithRed:84.f/255.f
                                                  green:84.f/255.f
                                                   blue:84.f/255.f
                                                  alpha:0.7f];
    dimmingView.layer.opacity = 0.f;
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.frame = CGRectMake(0.f, 0.f, CGRectGetWidth(transitionContext.containerView.bounds) - 100.f, CGRectGetHeight(transitionContext.containerView.bounds) - 500.f);
    
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
    
    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.toValue = @(transitionContext.containerView.center.y);
    positionAnimation.springSpeed = 5.f;
    positionAnimation.springBounciness = 17.f;
    
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 17.f;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2f, 1.3f)];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.8f);
    
    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
