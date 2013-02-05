//
//  DetailViewController.h
//  mybroadcast
//
//  Created by runes on 12-12-9.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Broadcast.h"
#import "CarInfo.h"
#import "CommonUtil.h"
#import "ASIHTTPRequest.h"
#import "FGalleryViewController.h"
#import "MBProgressHUD.h"
#import "EGOImageView.h"
#import "PriceViewController.h"

@interface DetailViewController : UIViewController<FGalleryViewControllerDelegate,MBProgressHUDDelegate,UIGestureRecognizerDelegate>
{
	MBProgressHUD *HUD;
    NSMutableDictionary *jsonDic;
    NSMutableArray *networkCaptions;
    NSMutableArray *networkImages;
    CGFloat lastScale;
    FGalleryViewController *networkGallery;
@private
    NSMutableData *mData;
}

@property (nonatomic,retain) CommonUtil *commonUtil;
@property (nonatomic,retain) ASIHTTPRequest *_request;
@property (nonatomic,retain) UIBarButtonItem *sendItem;
- (void)setDetailsView:(Broadcast*)broadcast;
- (void)setCarDetailsView:(CarInfo*)carInfo;
@end
