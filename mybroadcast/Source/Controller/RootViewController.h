//
//  RootViewController.h
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;
@interface RootViewController : UIViewController
{
    IBOutlet UIView* contentView;
    IBOutlet UILabel* summaryLabel;
    
    IBOutlet UITextField* remoteHostLabel;
    IBOutlet UIImageView* remoteHostIcon;
    IBOutlet UITextField* remoteHostStatusField;
    
    IBOutlet UIImageView* internetConnectionIcon;
    IBOutlet UITextField* internetConnectionStatusField;
    
    IBOutlet UIImageView* localWiFiConnectionIcon;
    IBOutlet UITextField* localWiFiConnectionStatusField;
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
}
@end
