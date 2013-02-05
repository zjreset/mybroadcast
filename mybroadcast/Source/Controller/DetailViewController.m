//
//  DetailViewController.m
//  mybroadcast
//
//  Created by runes on 12-12-9.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "DetailViewController.h"
#import "SBJson.h"
#import "PriceViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize commonUtil,_request,sendItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        commonUtil = [[CommonUtil alloc] init];
        networkCaptions = [[NSMutableArray alloc] init];
        networkImages = [[NSMutableArray alloc] init];
        mData = [NSMutableData new];
    }
    return self;
}

- (void) priceAction: (id)sender
{
    [[self navigationController] pushViewController:[[PriceViewController alloc] init] animated:YES];
}

- (void)setDetailsView:(Broadcast*)broadcast
{
    UIScrollView *view = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    //[view setBackgroundColor:[UIColor grayColor]];
    if (broadcast != NULL) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, 0, 80, 44)];
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];
        
        sendItem = [[UIBarButtonItem alloc]
                         initWithTitle:@"询价/预约"
                         style:UIBarButtonItemStyleDone
                         target:self
                         action:@selector(priceAction:)];
        sendItem.tag = 1;
        [buttons addObject:sendItem];
        
        [toolbar setItems:buttons animated:NO];
        toolbar.barStyle = -1;
        [buttons release];
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolbar] autorelease];
        [toolbar release];
        
        int _height = 38;
        //设置标题
        UITextView *ttv = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+5, self.view.bounds.size.width, _height)];
        ttv.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        ttv.textAlignment = NSTextAlignmentCenter;
        if (![commonUtil stringIsEmpty:broadcast.bTitle]) {
            ttv.text = broadcast.bTitle;
            ttv.editable = NO;
        }
        [view addSubview:ttv];
        [ttv release];
        //设置TIME
        UITextView *titv = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+_height, self.view.bounds.size.width, 24)];
        titv.textAlignment = NSTextAlignmentCenter;
        NSMutableString *time = [[NSMutableString alloc] init];
        if (![commonUtil stringIsEmpty:broadcast.bCreateTime]) {
            [time appendString:@"日期:"];
            [time appendString:broadcast.bCreateTime];
        }
        if (![commonUtil stringIsEmpty:broadcast.bUpdateTime]) {
            [time appendString:@"更新:"];
            [time appendString:broadcast.bUpdateTime];
        }
        if (![commonUtil stringIsEmpty:time]) {
            titv.text = time;
            titv.editable = NO;
            titv.font = [UIFont fontWithName:@"Helvetica-Oblique" size:10];
        }
        [view addSubview:titv];
        [time release];
        [titv release];
        _height = _height + 24;
        
        //增加分隔线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+_height, self.view.bounds.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineView];
        [lineView release];
        
        int bottom = 100;
        UIWebView *wv = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+_height+5, self.view.bounds.size.width, self.view.bounds.size.height-_height-bottom)];
        [wv setBackgroundColor:[UIColor whiteColor]];
        if (![commonUtil stringIsEmpty:broadcast.bContentStr]) {
            [wv loadHTMLString:broadcast.bContentStr baseURL:nil];
        }
        [view addSubview:wv];
        [wv release];
    }
    self.view = view;
}

- (void)setCarDetailsView:(CarInfo*)carInfo
{
    UIScrollView *view = [[[UIScrollView alloc] init] autorelease];
    int _height = 38;
    [view setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-100)];
    //[view setBackgroundColor:[UIColor grayColor]];
    view.scrollEnabled = TRUE;
    if (carInfo != NULL) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, 0, 80, 44)];
        NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];
        
        sendItem = [[UIBarButtonItem alloc]
                         initWithTitle:@"询价/预约"
                         style:UIBarButtonItemStyleDone
                         target:self
                         action:@selector(priceAction:)];
        sendItem.tag = 1;
        [buttons addObject:sendItem];
        
        [toolbar setItems:buttons animated:NO];
        toolbar.barStyle = -1;
        [buttons release];
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolbar] autorelease];
        [toolbar release];
                //设置车型
        UITextView *ttv = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+10, self.view.bounds.size.width-130, _height)];
        ttv.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        ttv.textAlignment = NSTextAlignmentCenter;
        if (![commonUtil stringIsEmpty:carInfo.carName]) {
            ttv.text = carInfo.carName;
            ttv.editable = NO;
        }
        [view addSubview:ttv];
        [ttv release];
        
        //设置级别
        UILabel *grade = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+20, self.view.bounds.origin.y+50, self.view.bounds.size.width-130, 34)];
        //titv.textAlignment = NSTextAlignmentCenter;
        NSMutableString *carGrade = [[NSMutableString alloc] init];
        if (![commonUtil stringIsEmpty:carInfo.carGrade]) {
            [carGrade appendString:@"级别:"];
            [carGrade appendString:carInfo.carGrade];
        }
        if (![commonUtil stringIsEmpty:carGrade]) {
            grade.text = carGrade;
            grade.font = [UIFont fontWithName:@"Helvetica" size:14];
            //grade.textColor = [UIColor redColor];
            [view addSubview:grade];
        }
        [carGrade release];
        [grade release];
        
        //设置价格
        UILabel *titv = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+20, self.view.bounds.origin.y+80, self.view.bounds.size.width-130, 34)];
        //titv.textAlignment = NSTextAlignmentCenter;
        NSMutableString *carPrice = [[NSMutableString alloc] init];
        if (![commonUtil stringIsEmpty:carInfo.carPrice]) {
            [carPrice appendString:@"指导价:"];
            [carPrice appendString:carInfo.carPrice];
        }
        if (![commonUtil stringIsEmpty:carPrice]) {
            titv.text = carPrice;
            titv.font = [UIFont fontWithName:@"Helvetica" size:14];
            //titv.textColor = [UIColor redColor];
            [view addSubview:titv];
        }
        [carPrice release];
        [titv release];
        
        int photowidth = 120;
        int photoheight = 90;
        EGOImageView *imageView = [[EGOImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-photowidth-5, self.view.bounds.origin.y + 5, photowidth, photoheight)];
        if (![commonUtil stringIsEmpty:carInfo.carPhoto]) {
            NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/upload/%@",commonUtil._globleUrl,carInfo.carPhoto]];
            imageView.imageURL = url;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
            [imageView addGestureRecognizer:singleTap];
            imageView.userInteractionEnabled = YES;
            imageView.layer.cornerRadius = 6;
            imageView.layer.masksToBounds = YES;
            [view addSubview:imageView];
            [singleTap release];
        }
        [imageView release];
        
        UILabel *nb = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-photowidth-5, self.view.bounds.origin.y+90+5, photowidth, 20)];
        nb.text = [NSString stringWithFormat:@"(%i张图片)",carInfo.carPhotoNum];
        nb.textAlignment = NSTextAlignmentCenter;
        nb.textColor = [UIColor redColor];
        nb.font = [UIFont fontWithName:@"Helvetica" size:14];
        [view addSubview:nb];
        [nb release];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/output/carInfo!outputlistCarPhotos.action?carInfoId=%@",commonUtil._globleUrl,carInfo.carId]];
        self._request= [ASIHTTPRequest requestWithURL:url];
        [self._request setDelegate:self];
        [_request startAsynchronous];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+5, 120, self.view.bounds.size.width-130, 24)];
        lb.text = @"车型配置:";
        lb.font = [UIFont fontWithName:@"Helvetica" size:14];
        [view addSubview:lb];
        [lb release];
        
        //增加分隔线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, 150, self.view.bounds.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:lineView];
        [lineView release];
        
        //int bottom = 100;
        UIWebView *configView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y+155, self.view.bounds.size.width, self.view.bounds.size.height-_height-44-155)];
        [configView setBackgroundColor:[UIColor whiteColor]];
        if (![commonUtil stringIsEmpty:carInfo.carConfigStr]) {
            [configView loadHTMLString:carInfo.carConfigStr baseURL:nil];
        }
        [view addSubview:configView];
        [configView reload];
        
        //拧的手势
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                     initWithTarget:self action:@selector(scale:)];
        [pinchRecognizer setDelegate:self];
        [view addGestureRecognizer:pinchRecognizer];
        [pinchRecognizer release];
        
        //平移手势
//        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panscale:)];
//        panRecognizer.maximumNumberOfTouches = 2;
//        panRecognizer.minimumNumberOfTouches = 2;
//        [panRecognizer setDelegate:self];
//        [view addGestureRecognizer:panRecognizer];
//        [panRecognizer release];
        
        //创建一个点击手势对象，该对象可以调用handelTap：方法
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTap:)];
//        [view addGestureRecognizer:tapGes];
//        [tapGes release];
//        [tapGes setNumberOfTouchesRequired:1];//触摸点个数
//        [tapGes setNumberOfTapsRequired:2];//点击次数
    }
    self.view = view;
}

-(void)handelTap:(UITapGestureRecognizer *)gestureRecognizer{
    NSLog(@"%s",__FUNCTION__);
    [NSRunLoop cancelPreviousPerformRequestsWithTarget:self];//双击事件取消延时
}

-(void)scale:(id)sender {
    
    [self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
    
    //当手指离开屏幕时,将lastscale设置为1.0
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        lastScale = 1.0;
        return;
    }
    
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [[(UIPinchGestureRecognizer*)sender view] setTransform:newTransform];
    
    lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

-(void)panscale:(UIPanGestureRecognizer*)gestureRecognizer{
    CGPoint curPoint = [gestureRecognizer locationInView:self.view];
    [self.view setCenter:curPoint];
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
        jsonDic = [jsparser objectWithString:responseData error:&error];
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
        [error release];
        jsonDic = [jsonDic objectForKey:@"carPhotosList"];
        int i=0;
        for (NSDictionary* dictionary in jsonDic) {
            i = i + 1;
            [networkCaptions addObject:[NSString stringWithFormat:@"第%i张",i]];
            [networkImages addObject:[NSString stringWithFormat:@"%@/upload/%@",commonUtil._globleUrl,[dictionary objectForKey:@"carPhotoPath"]]];
        }
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

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if ([networkImages count] > 0) {
        networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
        [self.navigationController pushViewController:networkGallery animated:YES];
        [networkGallery release];
    }
}

- (void)dealloc
{
    [super dealloc];
    [commonUtil release];
    [networkImages release];
    [networkCaptions release];
    [_request clearDelegatesAndCancel];
    [_request release];
    [mData release];
    lastScale = 1.0;
    [HUD release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
	return [networkImages count];
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
	return FGalleryPhotoSourceTypeNetwork;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
	return [networkCaptions objectAtIndex:index];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [networkImages objectAtIndex:index];
}

@end
