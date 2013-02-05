//
//  CarModel.h
//  mybroadcast
//
//  Created by runes on 13-1-15.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
@property (nonatomic,retain) NSString *modelId;
@property (nonatomic,retain) NSString *modelName;
@property (nonatomic,retain) NSString *modelPhoto;
@property (nonatomic,retain) NSString *createTimeStr;
@property (nonatomic,retain) UIImage *appIcon;

@end
