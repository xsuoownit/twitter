//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Xin Suo on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tweet";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    UIColor *bgColor = [UIColor colorWithRed:80/255.0 green:170/255.0 blue:241/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBarTintColor:bgColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *replyButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply)];
    self.navigationItem.rightBarButtonItem = replyButton;
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = self.tweet.user.screenname;
    self.descriptionLabel.text = self.tweet.text;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"m/dd/yyyy HH:mm a"];
    NSString *stringFromDate = [formatter stringFromDate:self.tweet.createdAt];
    self.createdAtLabel.text = stringFromDate;
    
    self.reweetsLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.retweetCount];
    self.favoritesLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.favoritesCount];
    
    UITapGestureRecognizer *replyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onReplyTapped)];
    replyTap.numberOfTapsRequired = 1;
    [self.replyImageView setUserInteractionEnabled:YES];
    [self.replyImageView addGestureRecognizer:replyTap];
    
    UITapGestureRecognizer *retweetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRetweetTapped)];
    retweetTap.numberOfTapsRequired = 1;
    [self.retweetImageView setUserInteractionEnabled:YES];
    [self.retweetImageView addGestureRecognizer:retweetTap];
    
    UITapGestureRecognizer *favoriteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onFavoriteTapped)];
    favoriteTap.numberOfTapsRequired = 1;
    [self.favoriteImageView setUserInteractionEnabled:YES];
    [self.favoriteImageView addGestureRecognizer:favoriteTap];
}

- (void)onReply {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.replyTextView.text;
    params[@"in_reply_to_status_id"] = self.tweet.idStr;
    [[TwitterClient sharedInstance]statusUpdate:params completion:^(NSError *error) {
        if (error == nil) {
            [self gotoHomePage];
        } else {
            NSLog(@"Failed to reply to tweet: %@", error);
        }
    }];
}

- (void)onReplyTapped {
    self.replyTextView.text = [NSString stringWithFormat:@"@%@ ", self.tweet.user.screenname];
    [self.replyTextView becomeFirstResponder];
}

- (void)onRetweetTapped {
    [[TwitterClient sharedInstance]statusRetweet:self.tweet.idStr completion:^(NSError *error) {
        if (error == nil) {
            self.reweetsLabel.text = [NSString stringWithFormat:@"%d", [self.reweetsLabel.text intValue] + 1];
            [self gotoHomePage];
        } else {
            NSLog(@"Failed to retweet: %@", error);
        }
    }];
}

- (void)onFavoriteTapped {
    [[TwitterClient sharedInstance]favorites:self.tweet.idStr completion:^(NSError *error) {
        if (error == nil) {
            self.favoritesLabel.text = [NSString stringWithFormat:@"%d", [self.favoritesLabel.text intValue] + 1];
        } else {
            NSLog(@"Failed to favorite tweet: %@", error);
        }
    }];
}

- (void)gotoHomePage {
    UIViewController *vc = [[TweetsViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
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
