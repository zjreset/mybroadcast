//
//  CarModel.m
//  mybroadcast
//
//  Created by runes on 13-1-15.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel
@synthesize modelId,modelName,modelPhoto,createTimeStr,appIcon;

-(void)dealloc
{
    [super dealloc];
    [modelId release];
    [modelName release];
    [modelPhoto release];
    [createTimeStr release];
    [appIcon release];
}
@end
