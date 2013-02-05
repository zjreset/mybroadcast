//
//  CarInfo.h
//  mybroadcast
//
//  Created by runes on 12-12-12.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfo : NSObject
{
    NSString *carId;
    NSInteger carModelId;
    NSString *carName;
    NSString *carGrade;
    NSString *carPrice;
    NSString *carPhoto;
    NSInteger carPhotoNum;
    NSString *carConfigStr;
    NSString *createPerson;
    NSString *createTimeStr;
}
@property (nonatomic,retain) NSString *carId;
@property (nonatomic) NSInteger carModelId;
@property (nonatomic,retain) NSString *carName;
@property (nonatomic,retain) NSString *carGrade;
@property (nonatomic,retain) NSString *carPrice;
@property (nonatomic,retain) NSString *carPhoto;
@property (nonatomic) NSInteger carPhotoNum;
@property (nonatomic,retain) NSString *carConfigStr;
@property (nonatomic,retain) NSString *createPerson;
@property (nonatomic,retain) NSString *createTimeStr;
@end
