//
//  TradeViewController.h
//  mybroadcast
//
//  Created by runes on 12-12-12.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"
#import "CommonUtil.h"
#import "ASIHTTPRequest.h"
#import "IconDownloader.h"
#import "MBProgressHUD.h"

@interface TradeViewController : UIViewController<UIGridViewDelegate, IconDownloaderDelegate,MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
    NSMutableDictionary *imageDownloadsInProgress;
    NSMutableDictionary *cellView;
    NSMutableDictionary *jsonDic;
@private
    NSMutableData *mData;
}
@property (nonatomic, retain) IBOutlet UIGridView *table;
@property (nonatomic,retain) NSMutableArray *_carInfolist;
@property (nonatomic,retain) CommonUtil *_commonUtil;
@property (nonatomic,retain) ASIHTTPRequest *_request;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, retain) NSMutableDictionary *cellView;

- (void)appImageDidLoad:(NSIndexPath *)indexPath;

@end
