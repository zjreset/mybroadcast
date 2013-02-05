//
//  MyScrollView.m
//  mybroadcast
//
//  Created by runes on 13-1-25.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return !self.delaysContentTouches;
}

@end
