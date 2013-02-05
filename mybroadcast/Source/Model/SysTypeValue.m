//
//  SysTypeValue.m
//  mybroadcast
//
//  Created by runes on 12-12-22.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "SysTypeValue.h"

@implementation SysTypeValue
@synthesize sId,sTypeId,sName,sNameNls;
- (void)dealloc
{
    [super dealloc];
    [sId release];
    sTypeId = 0;
    [sName release];
    [sNameNls release];
}
@end
