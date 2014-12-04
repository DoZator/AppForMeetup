//
//  UIView+Animation.m
//  AppForPresentation
//
//  Created by Oleg Bogatenko on 12/4/14.
//  Copyright (c) 2014 Oleg Bogatenko. All rights reserved.
//

#import "UIView+Animation.h"
#import <pop/POP.h>

@implementation UIView (Animation)

- (void)scaleUpViewToCenter:(CGPoint)centerPoint
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:centerPoint];
    [self.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 15.f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)scaleDownToSize:(float)size
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(size, size)];
    scaleAnimation.springBounciness = 15.f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

@end
