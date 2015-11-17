//
//  MenuViewController.h
//  twitter
//
//  Created by Xin Suo on 11/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>

- (void)menuViewController:(MenuViewController *)controller gotoViewController:(UIViewController *)viewController;

@end

@interface MenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;

@end
