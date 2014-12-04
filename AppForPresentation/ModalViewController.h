//
//  ModalViewController.h
//  AppForPresentation
//
//  Created by Oleg Bogatenko on 12/4/14.
//  Copyright (c) 2014 Oleg Bogatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalViewControllerDelegate <NSObject>

@optional
- (void)dismissModal;
@end

@interface ModalViewController : UIViewController

@property (nonatomic, assign) id <ModalViewControllerDelegate> delegate;

@end
