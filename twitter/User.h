//
//  User.h
//  twitter
//
//  Created by Xin Suo on 11/6/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenname;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic) NSInteger statusesCount;
@property (nonatomic) NSInteger followersCount;
@property (nonatomic) NSInteger friendsCount;

- (id) initWitDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;
+ (void)logout;

@end
