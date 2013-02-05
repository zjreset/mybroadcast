//
//  IndexViewController.h
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UITabBarController
{
    IBOutlet UITabBarItem *tabBar1;
    IBOutlet UITabBarItem *tabBar2;
    IBOutlet UITabBarItem *tabBar3;
    IBOutlet UITabBarItem *tabBar4;
    IBOutlet UITabBarItem *tabBar5;
}
@property(nonatomic,retain) UITabBarItem *tabBar1,*tabBar2,*tabBar3,*tabBar4,*tabBar5;

@end
