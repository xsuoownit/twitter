//
//  Menu.h
//  twitter
//
//  Created by Xin Suo on 11/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject

@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *title;

- (id) initWitDictionary:(NSDictionary *)dictionary;
- (NSArray *)menusWithArray:(NSArray *)array;

@end
