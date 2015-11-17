//
//  ProfileViewController.m
//  twitter
//
//  Created by Xin Suo on 11/16/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.nameLabel.text = self.user.name;
    self.screenNameLabel.text = self.user.screenname;
    self.numTweetsLabel.text = [NSString stringWithFormat:@"%ld", self.user.statusesCount];
    self.numFollowersLabel.text = [NSString stringWithFormat:@"%ld", self.user.followersCount];
    self.numFollowingLabel.text = [NSString stringWithFormat:@"%ld", self.user.friendsCount];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
