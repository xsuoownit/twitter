//
//  TweetCell.m
//  twitter
//
//  Created by Xin Suo on 11/8/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"

@implementation TweetCell

- (void)awakeFromNib {
    self.profileImageView.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    self.nameLabel.text = tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenname];
    self.descriptionTextView.text = tweet.text;
    self.timeLabel.text = tweet.timeDiff;
    [self.descriptionTextView sizeToFit];
    [self.descriptionTextView layoutIfNeeded];
    
    if (tweet.favoried) {
        [self.likeButton setImage:[UIImage imageNamed:@"like-action-on.png"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"like-action.png"] forState:UIControlStateNormal];
    }
    
    if (tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-action-on.png"] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-action.png"] forState:UIControlStateNormal];
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageViewTapped)];
    singleTap.numberOfTapsRequired = 1;
    [self.profileImageView setUserInteractionEnabled:YES];
    [self.profileImageView addGestureRecognizer:singleTap];
}

- (void)onImageViewTapped {
    [self.delegate tweetCell:self onTappedTweet:self.tweet];
}

@end
