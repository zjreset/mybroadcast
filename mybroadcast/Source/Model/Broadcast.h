//
//  Broadcast.h
//  mybroadcast
//
//  Created by runes on 12-12-8.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Broadcast : NSObject
{
    NSString *bid;
    NSString *bUpdatePerson;
    NSString *bContentStr;
    NSString *bContentTxtStr;
    NSString *bUpdateTime;
    NSString *bShortcut;
    NSString *bCreateTime;
    NSString *bCreatePerson;
    NSString *bTitle;
    NSInteger bIsGoing;
}
@property (nonatomic,retain) NSString *bid;
@property (nonatomic,retain) NSString *bUpdatePerson;
@property (nonatomic,retain) NSString *bContentStr;
@property (nonatomic,retain) NSString *bContentTxtStr;
@property (nonatomic,retain) NSString *bUpdateTime;
@property (nonatomic,retain) NSString *bShortcut;
@property (nonatomic,retain) NSString *bCreateTime;
@property (nonatomic,retain) NSString *bCreatePerson;
@property (nonatomic,retain) NSString *bTitle;
@property (nonatomic) NSInteger bIsGoing;
@end
