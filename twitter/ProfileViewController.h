//
//  ProfileViewController.h
//  twitter
//
//  Created by Xin Suo on 11/16/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) User *user;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowersLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowingLabel;

@end
