//
//  CommonUtil.h
//  mybroadcast
//
//  Created by runes on 12-12-8.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject
{
    NSString * globleUrl;
}
- (BOOL ) stringIsEmpty:(NSString *) aString;
@property (nonatomic,retain) NSString *_globleUrl;
@end
