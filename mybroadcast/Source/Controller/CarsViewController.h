//
//  CarsViewController.h
//  mybroadcast
//
//  Created by runes on 13-1-15.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUtil.h"
#import "ASIHTTPRequest.h"
#import "MHLazyTableImages.h"
#import "MBProgressHUD.h"
#import "EGORefreshTableHeaderView.h"

@class MHLazyTableImages;

@interface CarsViewController : UITableViewController<ASIHTTPRequestDelegate,MHLazyTableImagesDelegate,MBProgressHUDDelegate,EGORefreshTableHeaderDelegate>
{
	MBProgressHUD *HUD;
    NSMutableDictionary *jsonDic;
    MHLazyTableImages* lazyImages;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSString *modelId;
@private
    NSMutableData *mData;
}

@property (nonatomic,retain) NSMutableArray *_carInfolist;
@property (nonatomic,retain) CommonUtil *_commonUtil;
@property (nonatomic,retain) ASIHTTPRequest *_request;
@property (nonatomic,retain) NSString *modelId;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
