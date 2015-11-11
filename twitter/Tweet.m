//
//  Tweet.m
//  twitter
//
//  Created by Xin Suo on 11/6/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWitDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.user = [[User alloc] initWitDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        
        NSDate *now = [NSDate date];
        NSTimeInterval secondsBetween = [now timeIntervalSinceDate:self.createdAt];
        if (secondsBetween < 60) {
            self.timeDiff = [NSString stringWithFormat:@"%lds", (long)secondsBetween];
        } else if (secondsBetween < 3600) {
            self.timeDiff = [NSString stringWithFormat:@"%ldm", (long)secondsBetween / 60];
        } else if (secondsBetween < 86400) {
            self.timeDiff = [NSString stringWithFormat:@"%ldh", (long)secondsBetween / 3600];
        } else {
            self.timeDiff = [NSString stringWithFormat:@"%ldd", (long)secondsBetween / 86400];
        }
        
        self.favoried = [dictionary[@"favorited"] boolValue];
        self.retweetCount =  [dictionary[@"retweet_count"] intValue];
        self.favoritesCount = [dictionary[@"favorite_count"] intValue];
        self.idStr = dictionary[@"id_str"];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
    }
    return self;
}

- (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWitDictionary:dictionary]];
    }
    return tweets;
}

@end
