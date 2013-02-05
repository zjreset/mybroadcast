//
//  ActivityViewController.h
//  mybroadcast
//
//  Created by runes on 12-12-11.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUtil.h"
#import "ASIHTTPRequest.h"
#import "MHLazyTableImages.h"
#import "MBProgressHUD.h"
#import "EGORefreshTableHeaderView.h"

@class MHLazyTableImages;

@interface ActivityViewController : UITableViewController<ASIHTTPRequestDelegate,MHLazyTableImagesDelegate,MBProgressHUDDelegate,EGORefreshTableHeaderDelegate>
{
	MBProgressHUD *HUD;
    NSMutableDictionary *jsonDic;
    MHLazyTableImages* lazyImages;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
@private
    NSMutableData *mData;
}

@property (nonatomic,retain) NSMutableArray *_broadcastlist;
@property (nonatomic,retain) CommonUtil *_commonUtil;
@property (nonatomic,retain) ASIHTTPRequest *_request;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
