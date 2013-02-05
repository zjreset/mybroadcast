//
//  customAnnotation.h
//  mybroadcast
//
//  Created by runes on 12-12-16.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapViewController.h"
@interface customAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coords;

@end
