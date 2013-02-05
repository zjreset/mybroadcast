//
//  CarInfo.m
//  mybroadcast
//
//  Created by runes on 12-12-12.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "CarInfo.h"

@implementation CarInfo
@synthesize carId,carName,carGrade,carPrice,carPhoto,carPhotoNum,carConfigStr,createPerson,createTimeStr,carModelId;

- (void) dealloc
{
    [carId release];
    carModelId = 0;
    [carName release];
    [carGrade release];
    [carPrice release];
    [carPhoto release];
    carPhotoNum = 0;
    [carConfigStr release];
    [createPerson release];
    [createTimeStr release];
    [super dealloc];
}
@end
