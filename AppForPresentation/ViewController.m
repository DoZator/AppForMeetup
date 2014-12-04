//
//  ViewController.m
//  AppForPresentation
//
//  Created by Oleg Bogatenko on 12/4/14.
//  Copyright (c) 2014 Oleg Bogatenko. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Animation.h"

@interface ViewController ()
{
    IBOutlet UIButton *imageView;
    
    BOOL fullSize;
}

- (IBAction)touchImage:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 10.f;
    
    [imageView scaleDownToSize:0.5f];
    
    fullSize = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Actions

- (void)touchImage:(UIButton *)sender
{
    if (fullSize)
    {
        [imageView scaleDownToSize:0.5f];
        
        fullSize = NO;
    }
    else
    {
        [imageView scaleUpViewToCenter:self.view.center];
        
        fullSize = YES;
    }
}

@end
