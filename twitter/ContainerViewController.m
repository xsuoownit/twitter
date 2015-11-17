//
//  ContainerViewController.m
//  twitter
//
//  Created by Xin Suo on 11/16/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ContainerViewController.h"
#import "MenuViewController.h"
#import "TweetsViewController.h"
#import "NewTweetViewController.h"
#import "User.h"
#import "TweetCell.h"

@interface ContainerViewController () <MenuViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;

@property (nonatomic) CGFloat originalLeftMargin;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMenuView];
    [self setUpContentView:[TweetsViewController withRequestPage:Home]];
    
    self.title = @"Home";
    UIColor *bgColor = [UIColor colorWithRed:80/255.0 green:170/255.0 blue:241/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: bgColor}];
    [self.navigationController.navigationBar setTintColor:bgColor];
    
    UIBarButtonItem *signoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignout)];
    self.navigationItem.leftBarButtonItem = signoutButton;
    
    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNew)];
    self.navigationItem.rightBarButtonItem = newButton;
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)menuViewController:(MenuViewController *)controller gotoViewController:(UIViewController *)viewController {
    self.leftMarginConstraint.constant = 0;
    [self setUpContentView:viewController];
}

- (void)setUpContentView:(UIViewController *)viewController {
    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [self.contentView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)setUpMenuView {
    MenuViewController *mvc = [[MenuViewController alloc] init];
    mvc.delegate = self;
    [mvc willMoveToParentViewController:self];
    [self addChildViewController:mvc];
    [self.menuView addSubview:mvc.view];
    [mvc didMoveToParentViewController:self];
}

- (void)onNew {
    NewTweetViewController *ntvc = [[NewTweetViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ntvc];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)onSignout {
    [User logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalLeftMargin = self.leftMarginConstraint.constant;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            if (velocity.x > 0) {
                self.leftMarginConstraint.constant = self.view.frame.size.width - 200;
            } else {
                self.leftMarginConstraint.constant = 0;
            }
            [self.view layoutIfNeeded];
        }];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
