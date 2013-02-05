//
//  PriceViewController.h
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUtil.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"

@interface PriceViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
    UITextField *tCar;
    UITextField *tService;
    UILabel *_info;
@private
    NSMutableData *mData;
}
@property (nonatomic,retain) UILabel *lName;
@property (nonatomic,retain) UILabel *lLinkTel;
@property (nonatomic,retain) UILabel *lCar;
@property (nonatomic,retain) UILabel *lChepai;
@property (nonatomic,retain) UILabel *lService;
@property (nonatomic,retain) UILabel *lDate;
@property (nonatomic,retain) UILabel *lTime;
@property (nonatomic,retain) UILabel *lMemo;

@property (nonatomic,retain) UITextField *tName;
@property (nonatomic,retain) UITextField *tLinkTel;
@property (nonatomic,retain) UITextField *tCar;
@property (nonatomic,retain) UITextField *tChepai;
@property (nonatomic,retain) UITextField *tService;
@property (nonatomic,retain) UITextField *tDate;
@property (nonatomic,retain) UITextField *tTime;
@property (nonatomic,retain) UITextField *tMemo;
@property (nonatomic,retain) UIBarButtonItem *sendItem;
@property (nonatomic,retain) UITableView *alertTableView;
@property (nonatomic,retain) UIAlertView *dataAlertView;
@property (nonatomic,retain) UIAlertView *myAlertView;
@property (nonatomic,retain) CommonUtil *_commonUtil;
@property (nonatomic,retain) NSMutableDictionary *jsonDic;

@property (nonatomic,retain) ASIHTTPRequest *_request;
@property (nonatomic,retain) NSMutableArray *alertListContent;

//@property (nonatomic,retain) NSString *formatter;
//@property (nonatomic,retain) NSString *timestamp;
//@property (nonatomic,retain) NSString *datePicker;

@property (nonatomic,retain) UILabel *_label;
@property int _tag;
-(IBAction)backgroundTap:(id)sender;
@end
