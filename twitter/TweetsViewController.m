//
//  TweetsViewController.m
//  twitter
//
//  Created by Xin Suo on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetsViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"

@interface TweetsViewController ()

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for (Tweet *tweet in tweets) {
            NSLog(@"text: %@", tweet.text);
        }
    }];
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
