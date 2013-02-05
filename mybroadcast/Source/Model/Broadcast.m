//
//  Broadcast.m
//  mybroadcast
//
//  Created by runes on 12-12-8.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "Broadcast.h"

@implementation Broadcast
@synthesize bid,bTitle,bContentStr,bContentTxtStr,bCreatePerson,bCreateTime,bShortcut,bUpdatePerson,bUpdateTime,bIsGoing;

- (void)dealloc
{
    [super dealloc];
    [bid release];
    [bTitle release];
    [bContentStr release];
    [bContentTxtStr release];
    [bCreatePerson release];
    [bCreateTime release];
    [bShortcut release];
    [bUpdatePerson release];
    [bUpdateTime release];
    bIsGoing = 0;
}
@end
