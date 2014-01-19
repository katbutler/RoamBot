//
//  WorldsViewController.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WorldsViewController.h"
#import "LevelViewController.h"

@interface WorldsViewController ()

@end

@implementation WorldsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"space_background"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    UIImageView *earthImage = [[UIImageView alloc] initWithFrame:CGRectMake(130, 320, 350, 350)];
    [self.view addSubview:earthImage];
    
    earthImage.image = [UIImage imageNamed:@"Earth2"];
    
    UIImageView *moonImage = [[UIImageView alloc] initWithFrame:CGRectMake(110, 110, 600, 600)];
    [self.view addSubview:moonImage];
    
    moonImage.image = [UIImage imageNamed:@"Moon2"];
    
    //earth rotation
    [self runSpinAnimationOnView:earthImage duration:100.0 rotations:0.005 repeat:1.0];
    
    //moon rotation
    [self runSpinAnimationOnView:moonImage duration:100.0 rotations:0.02 repeat:1.0];
    
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    LevelViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(LevelViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(LevelViewController *)viewController index];
    
    
    index++;
    
    if (index == 3) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (LevelViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    LevelViewController *childViewController = [[LevelViewController alloc] initWithNibName:@"LevelViewController" bundle:nil];
    [childViewController setDelegate:self];
    childViewController.index = index;
    
    return childViewController;
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) playLevel:(int)level {
    [self performSegueWithIdentifier:@"WorldsToGameTransition" sender:self];
    
}

/**
 * Use this to get rid of the status bar.
 */
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
