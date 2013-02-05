//
//  MapViewController.m
//  mybroadcast
//
//  Created by runes on 12-12-16.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "MapViewController.h"
#import "customAnnotation.h"

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [_mapView setMapType:MKMapTypeStandard];
    //_mapView.delegate = self;
    CLLocationCoordinate2D coords;
    coords.latitude = 30.330876;
    coords.longitude = 120.181634;
    float zoomLevel = 0.018;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel,zoomLevel));
    [_mapView setRegion:[_mapView regionThatFits:region] animated:NO];
    
    customAnnotation *annotation = [[customAnnotation alloc]initWithCoordinate:coords];
    annotation.title = @"浙江康达汽车工贸有限公司(城北4S店)";
    annotation.subtitle = @"电话:0571-88280111;地址:杭州市石祥路303号";
    [_mapView addAnnotation:annotation];
    [annotation release];
    
    CLLocationCoordinate2D coords1;
    coords1.latitude = 30.29248;
    coords1.longitude = 120.250971;
    customAnnotation *annotation1 = [[customAnnotation alloc]initWithCoordinate:coords1];
    annotation1.title = @"浙江康达汽车工贸有限公司(城东4S店)";
    annotation1.subtitle = @"电话:0571-86016200;地址:杭州市艮山东路150号";
    [_mapView addAnnotation:annotation1];
    [annotation1 release];
    
    CLLocationCoordinate2D coords2;
    coords2.latitude = 30.311175;
    coords2.longitude = 120.154154;
    customAnnotation *annotation2 = [[customAnnotation alloc]initWithCoordinate:coords2];
    annotation2.title = @"浙江康达汽车工贸有限公司(大关4S店)";
    annotation2.subtitle = @"电话:0571-87334325;地址:杭州市大关路299号";
    [_mapView addAnnotation:annotation2];
    [annotation2 release];
    
    CLLocationCoordinate2D coords3;
    coords3.latitude = 30.2030876;
    coords3.longitude = 120.3065147;
    customAnnotation *annotation3 = [[customAnnotation alloc]initWithCoordinate:coords3];
    annotation3.title = @"浙江康达汽车工贸有限公司(萧山4S店)";
    annotation3.subtitle = @"电话:0571-82733030;地址:萧山区兴园路218号";
    [_mapView addAnnotation:annotation3];
    [annotation3 release];
    
    [self.view addSubview:_mapView];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(20, self.view.frame.size.height - 260, 100, 35);
    button1.backgroundColor = [UIColor grayColor];
    button1.alpha = 0.8;
    button1.tag = 1;
    [button1 setTitle:@"城北4S店" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(toOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    //[button1 release];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(20, self.view.frame.size.height - 220, 100, 35);
    button2.backgroundColor = [UIColor grayColor];
    button2.alpha = 0.8;
    button2.tag = 2;
    [button2 setTitle:@"城东4S店" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(toOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    //[button2 release];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(20, self.view.frame.size.height - 180, 100, 35);
    button3.backgroundColor = [UIColor grayColor];
    button3.alpha = 0.8;
    button3.tag = 3;
    [button3 setTitle:@"大关4S店" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(toOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    //[button3 release];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(20, self.view.frame.size.height - 140, 100, 35);
    button4.backgroundColor = [UIColor grayColor];
    button4.alpha = 0.8;
    button4.tag = 4;
    [button4 setTitle:@"萧山4S店" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(toOrderView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    //[button4 release];
}

- (void)toOrderView:(id)sender
{
    UIButton *button = (UIButton*)sender;
    CLLocationCoordinate2D coords;
    MKCoordinateRegion region;
    float zoomLevel = 0.018;
    switch (button.tag) {
        case 2:
            coords.latitude = 30.29248;
            coords.longitude = 120.250971;
            region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel,zoomLevel));
            [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
            break;
            
        case 3:
            coords.latitude = 30.311175;
            coords.longitude = 120.154154;
            region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel,zoomLevel));
            [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
            break;
            
        case 4:
            coords.latitude = 30.2030876;
            coords.longitude = 120.3065147;
            region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel,zoomLevel));
            [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
            break;
            
        default:
            coords.latitude = 30.330876;
            coords.longitude = 120.181634;
            region = MKCoordinateRegionMake(coords,MKCoordinateSpanMake(zoomLevel,zoomLevel));
            [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    _mapView = nil;
    [_mapView release];
}

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotation.title];
    if(pinView == nil)
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotation.title] autorelease];
    else
        pinView.annotation = annotation;
    [pinView setImage:[UIImage imageNamed:@"Icon-Small.png"]];
    pinView.animatesDrop = YES;
    pinView.canShowCallout = TRUE;
    return pinView;
}
@end
