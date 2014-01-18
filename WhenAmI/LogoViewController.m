//
//  ViewController.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LogoViewController.h"
#import "GameScene.h"

@implementation LogoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    double delayInSeconds = 2.0;
    double delayInSeconds2 = 4.0;
    
    UIImage *gameLogo = [UIImage imageNamed: @"ball"];
    
    dispatch_time_t logoDelay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(logoDelay, dispatch_get_main_queue(), ^(void){
        [self.imageView setImage:gameLogo];
    });
    
    /* TODO:
     * FIX PAGE SCROLLING
     */
    
    dispatch_time_t gameLogoDelay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds2 * NSEC_PER_SEC));
    dispatch_after(gameLogoDelay, dispatch_get_main_queue(), ^(void){
        [self performSegueWithIdentifier:@"LogoToWorldTransition" sender:self];
    });
    
}



- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

/**
 * Use this to get rid of the status bar.
 */
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
