//
//  TradeViewController.m
//  mybroadcast
//
//  Created by runes on 12-12-12.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "TradeViewController.h"
#import "Cell.h"
#import "SBJson.h"
#import "CarModel.h"
#import "CarsViewController.h"

@interface TradeViewController ()

@end

@implementation TradeViewController
@synthesize table;
@synthesize _carInfolist,_commonUtil,_request;
@synthesize imageDownloadsInProgress,cellView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //初始化commonUtil里面的主机链接地址信息
        _commonUtil = [[CommonUtil alloc] init];
        self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
        self.cellView = [NSMutableDictionary dictionary];
        mData = [NSMutableData new];
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"主营车型";
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/output/carInfo!outputlistCarModel.action",_commonUtil._globleUrl]];
    _request= [ASIHTTPRequest requestWithURL:url];
    [_request setDelegate:self];
    [_request startAsynchronous];
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
        CarModel *bc;
        jsonDic = [jsonDic objectForKey:@"carModelList"];
        _carInfolist = [[NSMutableArray alloc] init];
        for (NSDictionary* dictionary in jsonDic) {
            bc = [[[CarModel alloc] init] autorelease];
            bc.modelId = [dictionary objectForKey:@"id"];
            bc.modelName = [dictionary objectForKey:@"modelName"];
            bc.modelPhoto = [dictionary objectForKey:@"modelPhoto"];
            bc.createTimeStr = [dictionary objectForKey:@"CreateTimeStr"];
            [_carInfolist addObject:bc];
        }
        [error release];
    }
    [responseData release];
    [self.table reloadData];
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

- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
	return 80;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
	return 80;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
	return 4;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
	return [_carInfolist count];
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	Cell *cell = (Cell *)[grid dequeueReusableCell];
	if (cell == nil) {
		cell = [[[Cell alloc] init] autorelease];
	}
    
    //[lazyImages addLazyImageForCell:cell withIndexPath:[NSIndexPath indexPathForRow:rowIndex*4+columnIndex inSection:rowIndex*4+columnIndex]];
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:rowIndex*4+columnIndex];
	CarModel *carModel = [_carInfolist objectAtIndex:rowIndex*4+columnIndex];
    if (![_commonUtil stringIsEmpty:carModel.modelPhoto]) {
//        NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/upload/%@",_commonUtil._globleUrl,carInfo.carPhoto]];
//        
//        EGOImageView *imageView = [[EGOImageView alloc] init];
//        imageView.imageURL = url;
//        //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//        [cell.thumbnail addSubview:imageView];
        //异步加载
        [self startIconDownload:carModel forIndexPath:indexPath];
    }
	cell.label.text = [NSString stringWithFormat:@"%@", carModel.modelName];
    
	[self.cellView setObject:cell forKey:indexPath];
    //cell.label.textColor = [UIColor redColor];
	//cell.tag = rowIndex*4+columnIndex;
	return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
	//NSLog(@"%d, %d clicked", rowIndex, colIndex);
//    DetailViewController *detailsViewController = [[DetailViewController alloc] init];
//	CarInfo *carInfo = [self._carInfolist objectAtIndex:rowIndex*4+colIndex];
//    [detailsViewController setCarDetailsView:carInfo];
//    [[self navigationController] pushViewController:detailsViewController animated:YES];
//    [detailsViewController release];
    
    CarsViewController *carsViewController = [[CarsViewController alloc] initWithNibName:@"CarsViewController" bundle:nil];
    CarModel *carModel = [self._carInfolist objectAtIndex:rowIndex*4+colIndex];
    carsViewController.modelId = carModel.modelId;
    [[self navigationController] pushViewController:carsViewController animated:YES];
    [carsViewController release];
}


#pragma mark -
#pragma mark Table cell image support

- (void)startIconDownload:(CarModel *)carModel forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.carModel = carModel;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self._carInfolist count] > 0)
    {
//        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
//        for (NSIndexPath *indexPath in visiblePaths)
//        {
//            AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
//            
//            if (!appRecord.appIcon) // avoid the app icon download if the app already has an icon
//            {
//                [self startIconDownload:appRecord forIndexPath:indexPath];
//            }
//        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        
        Cell *cell = (Cell *)[cellView objectForKey:indexPath];
        //NSLog(@"tag:%i",cell.tag);
        // Display the newly loaded image
        cell.thumbnail.image = iconDownloader.carModel.appIcon;
    }
    
    // Remove the IconDownloader from the in progress list.
    // This will result in it being deallocated.
    [imageDownloadsInProgress removeObjectForKey:indexPath];
}

- (void)dealloc
{
    [super dealloc];
    [cellView release];
    [table release];
    [_carInfolist release];
    [_commonUtil release];
    [_request clearDelegatesAndCancel];
    [_request release];
    [jsonDic release];
    [mData release];
    [HUD release];
    [imageDownloadsInProgress release];
}
@end
