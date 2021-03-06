//
//  Tweet.h
//  twitter
//
//  Created by Xin Suo on 11/6/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *timeDiff;
@property (nonatomic) BOOL favoried;
@property (nonatomic, assign) NSInteger retweetCount;
@property (nonatomic, assign) NSInteger favoritesCount;
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic) BOOL retweeted;

- (id)initWitDictionary:(NSDictionary *)dictionary;

- (NSArray *)tweetsWithArray:(NSArray *)array;

@end
