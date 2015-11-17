//
//  TwitterClient.h
//  twitter
//
//  Created by Xin Suo on 11/5/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

typedef NS_ENUM(NSInteger, RequestPage) {
    Home,
    Mentions
};

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)statusUpdate:(NSDictionary *)status completion:(void (^)(NSError *error))completion;
- (void)statusRetweet:(NSString *)statusId completion:(void (^)(NSError *error))completion;
- (void)favorites:(NSString *)statusId completion:(void (^)(NSError *error))completion;
- (void)mentionsTimeLineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)showUser:(NSDictionary *)params completion:(void (^)(User *user, NSError *error))completion;

@end
