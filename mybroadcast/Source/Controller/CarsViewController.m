//
//  CarsViewController.m
//  mybroadcast
//
//  Created by runes on 13-1-15.
//  Copyright (c) 2013年 runes. All rights reserved.
//

#import "CarsViewController.h"
#import "CarInfo.h"
#import "SBJson.h"
#import "DetailViewController.h"

#define kCustomRowHeight  60.0
#define kCustomRowCount   7
#define kAppIconHeight    48

@interface CarsViewController ()

@end

@implementation CarsViewController

@synthesize _carInfolist,_commonUtil,_request,modelId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //初始化commonUtil里面的主机链接地址信息
        _commonUtil = [[CommonUtil alloc] init];
		lazyImages = [[MHLazyTableImages alloc] init];
		lazyImages.placeholderImage = [UIImage imageNamed:@"Icon-Small-50.png"];
		lazyImages.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view1 = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, - self.tableView.bounds.size.height, self.tableView.frame.size.width, self.view.bounds.size.height)];
        view1.delegate = self;
        [self.tableView addSubview:view1];
        _refreshHeaderView = view1;
        [view1 release];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [imageView setImage:[UIImage imageNamed:@"Default.png"]];
    imageView.alpha = 0.3;
    [self.tableView setBackgroundView:imageView];
    //[self.view addSubview:imageView];
    [imageView release];
    
    self.title = @"车型详情";
    [super viewDidLoad];
	lazyImages.tableView = self.tableView;
	self.tableView.rowHeight = kCustomRowHeight;
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    //    [imageView setImage:[UIImage imageNamed:@"121.png"]];
    //    imageView.alpha = 0.1;
    //    [self.view addSubview:imageView];
    //    [imageView release];
    
    self.tableView.scrollEnabled = YES;
    [self requestServerData];
}

- (void)requestServerData
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/output/carInfo!outputlistCarInfo.action?modelId=%@",_commonUtil._globleUrl,modelId]];
    _request= [ASIHTTPRequest requestWithURL:url];
    [_request setDelegate:self];
    [_request startAsynchronous];
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
    mData = [NSMutableData new];
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
        CarInfo *bc;
        jsonDic = [jsonDic objectForKey:@"carInfoList"];
        _carInfolist = [[NSMutableArray alloc] init];
        for (NSDictionary* dictionary in jsonDic) {
            bc = [[[CarInfo alloc] init] autorelease];
            bc.carId = [dictionary objectForKey:@"id"];
            bc.carName = [dictionary objectForKey:@"carName"];
            bc.carGrade = [dictionary objectForKey:@"carGrade"];
            bc.carPrice = [dictionary objectForKey:@"carPrice"];
            bc.carPhoto = [dictionary objectForKey:@"carPhoto"];
            bc.carPhotoNum = [[dictionary objectForKey:@"carPhotoNum"] intValue];
            bc.carConfigStr = [dictionary objectForKey:@"carConfigStr"];
            bc.CreatePerson = [dictionary objectForKey:@"CreatePerson"];
            bc.createTimeStr = [dictionary objectForKey:@"CreateTimeStr"];
            [_carInfolist addObject:bc];
        }
        [error release];
    }
    [responseData release];
    [self.tableView reloadData];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    //[_request clearDelegatesAndCancel];
    //[_request release];
    [_carInfolist release];
    [_commonUtil release];
    [jsonDic release];
    [HUD release];
    [mData release];
	lazyImages.delegate = nil;
	[lazyImages release];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//		return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int count = [self._carInfolist count];
    if (count == 0)
        return kCustomRowCount;  // enough rows to fill the screen
	else
		return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int nodeCount = [self._carInfolist count];
    
	if (nodeCount == 0 && indexPath.row == 0)
	{
		static NSString* PlaceholderCellIdentifier = @"PlaceholderCell";
        
		UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PlaceholderCellIdentifier] autorelease];
			cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
        
        //		cell.detailTextLabel.text = @"Loading…";
		return cell;
	}
	else
	{
		static NSString* CellIdentifier = @"LazyTableCell";
        
		UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
        
		if (nodeCount > 0)
		{
            CarInfo *carInfo = [self._carInfolist objectAtIndex:indexPath.row];
            if (carInfo != NULL) {
                //设置标题
                if (![_commonUtil stringIsEmpty:carInfo.carName]) {
                    cell.textLabel.text = carInfo.carName;
                }
                //设置内容
                //UIWebView *tv = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-60, 30)];
                if (![_commonUtil stringIsEmpty:carInfo.carPrice]) {
                    //            [tv loadHTMLString:bc.bContentStr baseURL:nil];
                    //            [cell._content addSubview:tv];
                    cell.detailTextLabel.text = carInfo.carPrice;
                    cell.detailTextLabel.textColor = [UIColor redColor];
                }
                else{
                    cell.detailTextLabel.text = @"";
                }
                //设置缺省图片
                cell.imageView.image = [UIImage imageNamed:@"Icon-Small-50.png"];
                //修改默认图片的宽高比
                [cell.imageView setTransform:CGAffineTransformMakeScale(1.33, 1)];
                cell.imageView.layer.cornerRadius = 6;
                cell.imageView.layer.masksToBounds = YES;
                if (![_commonUtil stringIsEmpty:carInfo.carPhoto]) {
                    [lazyImages addLazyImageForCell:cell withIndexPath:indexPath];
                }
            }
		}
        
		return cell;
	}
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
	[lazyImages scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
	[lazyImages scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailsViewController = [[DetailViewController alloc] init];
	CarInfo *carInfo = [self._carInfolist objectAtIndex:indexPath.row];
    [detailsViewController setCarDetailsView:carInfo];
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}

#pragma mark -
#pragma mark MHLazyTableImagesDelegate

- (NSURL*)lazyImageURLForIndexPath:(NSIndexPath*)indexPath
{
    CarInfo *bc = [self._carInfolist objectAtIndex:indexPath.row];
    return [NSURL URLWithString: [NSString stringWithFormat:@"%@/upload/%@",_commonUtil._globleUrl,bc.carPhoto]];
}

- (UIImage*)postProcessLazyImage:(UIImage*)image forIndexPath:(NSIndexPath*)indexPath
{
    if (image.size.width != kAppIconHeight && image.size.height != kAppIconHeight)
	{
        CGSize itemSize = CGSizeMake(kAppIconHeight, kAppIconHeight);
		UIGraphicsBeginImageContextWithOptions(itemSize, YES, 0);
		CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
		[image drawInRect:imageRect];
		UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		return newImage;
    }
    else
    {
        return image;
    }
}

#pragma mark –
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    NSLog(@"==开始加载数据");
    _reloading = YES;
    //执行请求
    [self requestServerData];
    //[self.tableView reloadData];
}

- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}
#pragma mark –
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

#pragma mark –
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

@end
