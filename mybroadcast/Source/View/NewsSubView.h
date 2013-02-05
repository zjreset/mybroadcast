//
//  NewsSubView.h
//  mybroadcast
//
//  Created by runes on 12-12-8.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsSubView : UIView
{
    IBOutlet UIImageView *imageView;
    IBOutlet UITextView *textView;
}
@property (nonatomic,retain)UIImageView* imageView;
@property (nonatomic,retain)UITextView* textView;
@end
