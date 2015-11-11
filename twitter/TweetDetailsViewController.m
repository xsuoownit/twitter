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
    UIColor *bgColor = [UIColor colorWithRed:80/255.0 green:170/255.0 blue:241/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: bgColor}];
    [self.navigationController.navigationBar setTintColor:bgColor];
    
    UIBarButtonItem *replyButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply)];
    self.navigationItem.rightBarButtonItem = replyButton;
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = self.tweet.user.screenname;
    self.descriptionTextView.text = self.tweet.text;
    [self.descriptionTextView sizeToFit];
    [self.descriptionTextView layoutIfNeeded];
    
    if (self.tweet.favoried) {
        [self.likeButton setImage:[UIImage imageNamed:@"like-action-on.png"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"like-action.png"] forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-action-on.png"] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-action.png"] forState:UIControlStateNormal];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm a"];
    NSString *stringFromDate = [formatter stringFromDate:self.tweet.createdAt];
    self.createdAtLabel.text = stringFromDate;
    
    self.reweetsLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.retweetCount];
    self.favoritesLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.favoritesCount];
}

- (IBAction)onReplyTapped:(id)sender {
    self.replyTextView.text = [NSString stringWithFormat:@"@%@ ", self.tweet.user.screenname];
    [self.replyTextView becomeFirstResponder];
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

- (IBAction)onRetweetTapped:(id)sender {
    if (self.tweet.retweeted) {
        // do nothing
    } else {
        [[TwitterClient sharedInstance]statusRetweet:self.tweet.idStr completion:^(NSError *error) {
            if (error == nil) {
                self.reweetsLabel.text = [NSString stringWithFormat:@"%d", [self.reweetsLabel.text intValue] + 1];
                [self gotoHomePage];
            } else {
                NSLog(@"Failed to retweet: %@", error);
            }
        }];
    }
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-action-on.png"] forState:UIControlStateNormal];
}

- (IBAction)onFavoriteTapped:(id)sender {
    if (self.tweet.favoried) {
        // do nothing
    } else {
        [[TwitterClient sharedInstance]favorites:self.tweet.idStr completion:^(NSError *error) {
            if (error == nil) {
                self.favoritesLabel.text = [NSString stringWithFormat:@"%d", [self.favoritesLabel.text intValue] + 1];
            } else {
                NSLog(@"Failed to favorite tweet: %@", error);
            }
        }];
        [self.likeButton setImage:[UIImage imageNamed:@"like-action-on.png"] forState:UIControlStateNormal];
    }
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
