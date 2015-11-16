//
//  MenuCell.h
//  twitter
//
//  Created by Xin Suo on 11/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"

@interface MenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) Menu *menu;

@end
