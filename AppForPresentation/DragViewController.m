//
//  DragViewController.m
//  AppForPresentation
//
//  Created by Oleg Bogatenko on 12/4/14.
//  Copyright (c) 2014 Oleg Bogatenko. All rights reserved.
//

#import "DragViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Animation.h"
#import "AGGeometryKit.h"
#import "POPAnimatableProperty+AGGeometryKit.h"

@interface DragViewController ()
{
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, assign) AGKQuad desiredQuad;

- (IBAction)panGestureChanged:(UIPanGestureRecognizer *)recognizer;

@end

@implementation DragViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 10.f;
    
    [imageView.layer ensureAnchorPointIsSetToZero];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.desiredQuad = imageView.layer.quadrilateral;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (CGFloat)longestDistanceOfPointsInQuad:(AGKQuad)quad toPoint:(CGPoint)point
{
    CGFloat longestDistanceFromTouch = 0.0;
    
    for (int cornerIndex = 0; cornerIndex < 4; cornerIndex++)
    {
        CGPoint currentCornerPoint = quad.v[cornerIndex];
        CGFloat distance = fabs(CGPointLengthBetween_AGK(point, currentCornerPoint));
        
        if (distance > longestDistanceFromTouch)
        {
            longestDistanceFromTouch = distance;
        }
    }
    return longestDistanceFromTouch;
}

- (void)panGestureChanged:(UIPanGestureRecognizer *)recognizer
{
    [self panGestureChanged:recognizer animationTuning:^(POPSpringAnimation *anim, int cornerIndex, CGFloat dragCoefficient) {
        anim.dynamicsMass       = 100;
        anim.dynamicsFriction   = 37;
        anim.dynamicsTension    = 2;
        anim.springBounciness   = AGKInterpolate(10, 20, dragCoefficient);
        anim.springSpeed        = AGKInterpolate(10, 20, dragCoefficient);
    }];
}

- (void)panGestureChanged:(UIPanGestureRecognizer *)recognizer
          animationTuning:(void(^)(POPSpringAnimation *anim, int cornerIndex, CGFloat dragCoefficient))tuning
{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint pointOfTouchInside = [recognizer locationInView:recognizer.view];
    self.desiredQuad = AGKQuadMove(self.desiredQuad, translation.x, translation.y);
    AGKQuad innerQuad = [recognizer.view.layer.superlayer convertAGKQuad:self.desiredQuad toLayer:recognizer.view.layer];
    NSArray *cornersForProperties = @[kPOPLayerAGKQuadTopLeft, kPOPLayerAGKQuadTopRight, kPOPLayerAGKQuadBottomRight, kPOPLayerAGKQuadBottomLeft];
    CGFloat longestDistanceFromTouch = [self longestDistanceOfPointsInQuad:innerQuad toPoint:pointOfTouchInside];
    
    for (int cornerIndex = 0; cornerIndex < 4; cornerIndex++)
    {
        NSString *propertyName = cornersForProperties[cornerIndex];
        
        POPSpringAnimation *anim = [imageView.layer pop_animationForKey:propertyName];
        if(anim == nil)
        {
            anim = [POPSpringAnimation animation];
            anim.property = [POPAnimatableProperty AGKPropertyWithName:propertyName];
            [imageView.layer pop_addAnimation:anim forKey:propertyName];
        }
        
        CGPoint currentCornerPoint = innerQuad.v[cornerIndex];
        CGFloat distance = fabs(CGPointLengthBetween_AGK(pointOfTouchInside, currentCornerPoint));
        CGFloat dragCoefficient = AGKRemapToZeroOne(distance, longestDistanceFromTouch, 0);
        
        anim.toValue = [NSValue valueWithCGPoint:self.desiredQuad.v[cornerIndex]];
        tuning(anim, cornerIndex, dragCoefficient);
    }
    
    [recognizer setTranslation:CGPointZero inView:self.view];
}

@end
