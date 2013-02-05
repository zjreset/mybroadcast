//
//  NewsViewController.h
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCycleScrollView.h"
#import "CommonUtil.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"

@interface NewsViewController : UIViewController
<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,ASIHTTPRequestDelegate,MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
    NSMutableDictionary *jsonDic;
@private
    NSMutableData *mData;
}


@property (nonatomic,retain) NSMutableArray *_broadcastlist;
@property (nonatomic,retain) CommonUtil *_commonUtil;
@property (nonatomic,retain) ASIHTTPRequest *_request;
@end
