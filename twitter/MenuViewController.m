//
//  MenuViewController.m
//  twitter
//
//  Created by Xin Suo on 11/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MenuViewController.h"
#import "Menu.h"
#import "MenuCell.h"
#import "ContainerViewController.h"
#import "ProfileViewController.h"
#import "TweetsViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *menus;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menus = [[Menu alloc] menusWithArray:@[@{@"iconName": @"profile.png", @"title": @"Profile"},
                                                @{@"iconName": @"home.png", @"title": @"Home"},
                                                @{@"iconName": @"at.png", @"title": @"Mentions"}]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    [cell setMenu:self.menus[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.delegate menuViewController:self gotoViewController:[[ProfileViewController alloc] init]];
            break;
        case 1:
            [self.delegate menuViewController:self gotoViewController:[TweetsViewController withRequestPage:Home]];
            break;
        case 2:
            [self.delegate menuViewController:self gotoViewController:[TweetsViewController withRequestPage:Mentions]];
        default:
            break;
    }
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
