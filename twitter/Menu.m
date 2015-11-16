//
//  Menu.m
//  twitter
//
//  Created by Xin Suo on 11/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "Menu.h"

@implementation Menu

- (id) initWitDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.iconName = dictionary[@"iconName"];
        self.title = dictionary[@"title"];
    }
    return self;
}

- (NSArray *)menusWithArray:(NSArray *)array {
    NSMutableArray *menus = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        [menus addObject:[[Menu alloc] initWitDictionary:dictionary]];
    }
    return menus;
}

@end
