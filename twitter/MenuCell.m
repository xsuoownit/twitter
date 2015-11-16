//
//  MenuCell.m
//  twitter
//
//  Created by Xin Suo on 11/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMenu:(Menu *)menu {
    _menu = menu;
    [self.iconImageView setImage:[UIImage imageNamed:menu.iconName]];
    self.titleLabel.text = menu.title;
}

@end
