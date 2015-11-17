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
#import "TweetCell.h"
#import "TweetDetailsViewController.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic) enum RequestPage requestPage;

@end

@implementation TweetsViewController

+ (id)withRequestPage:(RequestPage)requestPage {
    TweetsViewController *vc = [[TweetsViewController alloc] init];
    vc.requestPage = requestPage;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 140;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self onRefresh];
}

- (void)onRefresh {
    if (self.requestPage == Mentions) {
        [[TwitterClient sharedInstance] mentionsTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }];
    } else {
        [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell setTweet:self.tweets[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetDetailsViewController *tdvc = [[TweetDetailsViewController alloc] init];
    tdvc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:tdvc animated:YES];
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
