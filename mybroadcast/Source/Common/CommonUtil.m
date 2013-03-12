//
//  CommonUtil.m
//  mybroadcast
//
//  Created by runes on 12-12-8.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil
@synthesize _globleUrl;

- (id)init
{
    _globleUrl = @"http://www.myheige.com:8088/kangda";
    //_globleUrl = @"http://192.168.1.102:8088/broadcast";
    //_globleUrl = @"http://localhost:8088/broadcast";
    return [super init];
}

- (BOOL ) stringIsEmpty:(NSString *) aString {
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    return NO;
}
@end
