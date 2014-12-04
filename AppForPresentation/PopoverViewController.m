//
//  PopoverViewController.m
//  AppForPresentation
//
//  Created by Oleg Bogatenko on 12/4/14.
//  Copyright (c) 2014 Oleg Bogatenko. All rights reserved.
//

#import "PopoverViewController.h"
#import "SMPresentingAnimator.h"
#import "SMDismissingAnimator.h"
#import "ModalViewController.h"

@interface PopoverViewController () <UIViewControllerTransitioningDelegate, ModalViewControllerDelegate>
{
    ModalViewController *modalViewController;
}

- (IBAction)showModal:(id)sender;

@end

@implementation PopoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Actions

- (void)showModal:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (!modalViewController)
    {
        modalViewController = [storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
        
        modalViewController.delegate = self;
        
        modalViewController.transitioningDelegate = self;
        modalViewController.modalPresentationStyle = UIModalPresentationCustom;
        
        [self presentViewController:modalViewController animated:YES completion:nil];
    }
}

#pragma mark Delegate

- (void)dismissModal
{
    modalViewController = nil;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [SMPresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [SMDismissingAnimator new];
}

@end
