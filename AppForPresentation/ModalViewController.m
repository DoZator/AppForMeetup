//
//  ModalViewController.m
//  AppForPresentation
//
//  Created by Oleg Bogatenko on 12/4/14.
//  Copyright (c) 2014 Oleg Bogatenko. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

- (IBAction)close:(id)sender;

@end

@implementation ModalViewController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 10.f;
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (delegate && [delegate respondsToSelector:@selector(dismissModal)])
        [delegate dismissModal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
