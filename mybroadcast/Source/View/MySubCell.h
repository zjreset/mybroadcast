//
//  MySubCell.h
//  mybroadcast
//
//  Created by runes on 12-12-11.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySubCell : UITableViewCell
{
    IBOutlet UILabel *ltitle;
    IBOutlet UILabel *lcontent;
    IBOutlet UIImageView *iImageView;
}
@property (nonatomic,retain) UILabel *_title;
@property (nonatomic,retain) UILabel *_content;
@property (nonatomic,retain) UIImageView *_iImageView;
@end
