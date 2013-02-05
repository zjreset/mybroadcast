//
//  IndexViewController.m
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "IndexViewController.h"
#import "NewsViewController.h"
#import "ActivityViewController.h"
#import "TradeViewController.h"
#import "PriceViewController.h"
#import "LinkViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize tabBar1,tabBar2,tabBar3,tabBar4,tabBar5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self){
        NewsViewController *view1 = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
        ActivityViewController *view2 = [[ActivityViewController alloc] initWithNibName:@"ActivityViewController" bundle:nil];
        TradeViewController *view3 = [[TradeViewController alloc] initWithNibName:@"TradeViewController" bundle:nil];
        PriceViewController *view4 = [[PriceViewController alloc] init];
        LinkViewController *view5 = [[LinkViewController alloc] initWithNibName:@"LinkViewController" bundle:nil];
        
        
        tabBar1 = [[UITabBarItem alloc] initWithTitle:@"康达汽车" image:[UIImage imageNamed:@"icon_home.png"] tag:1];
        tabBar2 = [[UITabBarItem alloc] initWithTitle:@"优惠活动" image:[UIImage imageNamed:@"icon_favorities_add.png"] tag:2];
        tabBar3 = [[UITabBarItem alloc] initWithTitle:@"主营车型" image:[UIImage imageNamed:@"icon_star.png"] tag:3];
        tabBar4 = [[UITabBarItem alloc] initWithTitle:@"询价/预约" image:[UIImage imageNamed:@"icon_time.png"] tag:4];
        tabBar5 = [[UITabBarItem alloc] initWithTitle:@"联系我们" image:[UIImage imageNamed:@"icon_paper_plane.png"] tag:5];
        
        [view1 setTabBarItem:tabBar1];
        [view2 setTabBarItem:tabBar2];
        [view3 setTabBarItem:tabBar3];
        [view4 setTabBarItem:tabBar4];
        [view5 setTabBarItem:tabBar5];
        
        
        UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:view1];
        UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:view2];
        UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:view3];
        UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:view4];
        UINavigationController *navController5 = [[UINavigationController alloc] initWithRootViewController:view5];
        
        self.viewControllers = [NSArray arrayWithObjects:navController1,navController2,navController3,navController4,navController5, nil];
        [view1 release];
        [view2 release];
        [view3 release];
        [view4 release];
        [view5 release];
        [navController1 release];
        [navController2 release];
        [navController3 release];
        [navController4 release];
        [navController5 release];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [tabBar1 release];
    [tabBar2 release];
    [tabBar3 release];
    [tabBar4 release];
    [tabBar5 release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
