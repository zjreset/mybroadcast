//
//  NewsViewController.m
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "NewsViewController.h"
#import "SBJson.h"
#import "Broadcast.h"
#import "DetailViewController.h"
#import <unistd.h>
#import "EGOImageView.h"

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize _broadcastlist;
@synthesize _commonUtil;
@synthesize _request;

- (void)dealloc
{
    [super dealloc];
    [_request clearDelegatesAndCancel];
    [_request release];
    [jsonDic release];
    [HUD release];
    [mData release];
    [_broadcastlist release];
    [_commonUtil release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //初始化commonUtil里面的主机链接地址信息
        _commonUtil = [[CommonUtil alloc] init];
        mData = [NSMutableData new];
        _broadcastlist = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"浙江康达汽车";
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/output/broadcast!outputlistBroadcast.action",_commonUtil._globleUrl]];
     _request= [ASIHTTPRequest requestWithURL:url];
    [_request setDelegate:self];
    [_request startAsynchronous];         //对应的同步请求[request startSynchronous];
    //[url release];
    // Do any additional setup after loading the view from its nib.
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	[HUD hide:YES];
    NSError *error = [request error];
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"获取服务器数据失败!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)requestStarted:(ASIHTTPRequest *)request
{
	HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
}

-(void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    [mData appendData:data];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseData = [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    if (responseData != nil) {
        SBJsonParser * jsparser = [[SBJsonParser alloc] init];
        NSError * error = nil;
        jsonDic = [[jsparser objectWithString:responseData error:&error] objectForKey:@"broadcastList"];
        [jsparser release];
        if (error) {
            [HUD hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"服务器数据解析失败!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }
        Broadcast *bc;
        for (NSDictionary* dictionary in jsonDic) {
            bc = [[[Broadcast alloc] init] autorelease];
            bc.bid = [dictionary objectForKey:@"id"];
            bc.bTitle = [dictionary objectForKey:@"bTitle"];
            bc.bContentStr = [dictionary objectForKey:@"bContentStr"];
            bc.bContentTxtStr = [dictionary objectForKey:@"bContentTxtStr"];
            bc.bShortcut = [dictionary objectForKey:@"bShortcut"];
            bc.bCreatePerson = [dictionary objectForKey:@"bCreatePerson"];
            bc.bCreateTime = [dictionary objectForKey:@"bCreateTimeStr"];
            bc.bUpdatePerson = [dictionary objectForKey:@"bUpdatePerson"];
            bc.bUpdateTime = [dictionary objectForKey:@"bUpdateTimeStr"];
            bc.bIsGoing = [[dictionary objectForKey:@"bIsGoing"] integerValue];
            if (bc.bIsGoing == 1) {
                [_broadcastlist addObject:bc];
            }
        }
        [error release];
        XLCycleScrollView *csView = [[XLCycleScrollView alloc] initWithFrame:self.view.bounds];
        csView.delegate = self;
        csView.datasource = self;
        [self.view addSubview:csView];
    }
    [responseData release];
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfPages
{
    return [_broadcastlist count]<5?[_broadcastlist count]:5;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    Broadcast *bc = [_broadcastlist objectAtIndex:index];
    UIView *view = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
    [view setBackgroundColor:[UIColor whiteColor]];
    if (bc != NULL) {
        int imageHeight = 240;//self.view.bounds.size.height*2/3;
        //设置图片
        if (![_commonUtil stringIsEmpty:bc.bShortcut]) {
            NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/upload/%@",_commonUtil._globleUrl,bc.bShortcut]];
            EGOImageView *iv = [[EGOImageView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, imageHeight)];
            //[iv setBackgroundColor:[UIColor grayColor]];
            iv.imageURL = url;
            [view addSubview:iv];
            //[url release];
            [iv release];
        }
        //设置标题
        UILabel *ttv = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+imageHeight-36, self.view.bounds.size.width, 36)];
        [ttv setBackgroundColor:[UIColor blackColor]];
        ttv.alpha = 0.6;
        ttv.textColor = [UIColor whiteColor];
        ttv.textAlignment = NSTextAlignmentCenter;
        //ttv.editable = NO;
        if (![_commonUtil stringIsEmpty:bc.bTitle]) {
            ttv.text = bc.bTitle;
        }
        [view addSubview:ttv];
        [ttv release];
        //设置内容
        UILabel *tv = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+5, self.view.bounds.origin.y+imageHeight, self.view.bounds.size.width-10, self.view.bounds.size.height-imageHeight-30)];
        [tv setBackgroundColor:[UIColor whiteColor]];
        //tv.editable = NO;
        //tv.alpha = 0.1;
        if (![_commonUtil stringIsEmpty:bc.bContentTxtStr]) {
            //[tv loadHTMLString:bc.bContentStr baseURL:nil];
            tv.text = [NSString stringWithFormat:@"%@\n\n\n\n",bc.bContentTxtStr];
            tv.font = [UIFont systemFontOfSize:14];
            tv.lineBreakMode = NSLineBreakByWordWrapping;
            tv.numberOfLines = 4;
            //tv.textColor = [UIColor blackColor];
        }
        [view addSubview:tv];
        [tv release];
    }
    return view;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    DetailViewController *detailsViewController = [[DetailViewController alloc] init];
    Broadcast *musicInfo = [self._broadcastlist objectAtIndex:index];
    [detailsViewController setDetailsView:musicInfo];
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}

@end
