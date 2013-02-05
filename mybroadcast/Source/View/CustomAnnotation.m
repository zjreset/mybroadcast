//
//  customAnnotation.m
//  mybroadcast
//
//  Created by runes on 12-12-16.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "customAnnotation.h"

@implementation customAnnotation
@synthesize coordinate,title,subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coords
{
    if (self = [super init]) {
        coordinate = coords;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [title release];
    [subtitle release];
}
@end
