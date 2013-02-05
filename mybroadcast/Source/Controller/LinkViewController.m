//
//  LinkViewController.m
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "LinkViewController.h"
#import "MapViewController.h"

#import"myimgeview.h"
#define RADIUS 100.0
#define PHOTONUM 5
#define PHOTOSTRING @"icon"
#define TAGSTART 1000
#define TIME 1.5
#define SCALENUMBER 1.25
int array [PHOTONUM][PHOTONUM] ={
	{0,1,2,3,4},
	{4,0,1,2,3},
	{3,4,0,1,2},
	{2,3,4,0,1},
	{1,2,3,4,0}
};
@interface LinkViewController ()

@end

@implementation LinkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

CATransform3D rotationTransform1[PHOTONUM];
- (void)viewDidLoad
{
    self.title = @"联系我们";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
	UIImageView *backview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default.png"]];
	//backview.frame = self.view.frame;
	backview.center = CGPointMake(backview.center.x, backview.center.y);
	
	backview.alpha = 0.3;
	[self.view addSubview:backview];
	
    NSArray *textArray = [NSArray arrayWithObjects:@"销售热线",@"售后服务",@"康达官网",@"车贷方案",@"网点地图",nil];
    
	float centery = self.view.center.y - 140;
	float centerx = self.view.center.x;
    
	for (int i = 0;i<PHOTONUM;i++ )
	{
		float tmpy = centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
		float tmpx = centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
		myimgeview *addview1 =	[[myimgeview alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",PHOTOSTRING,i]] text:[textArray objectAtIndex:i]];
        addview1.frame = CGRectMake(0.0, 0.0,120,140);
		[addview1 setdege:self];
		addview1.tag = TAGSTART + i;
		addview1.center = CGPointMake(tmpx,tmpy);
		rotationTransform1[i] = CATransform3DIdentity;
		
		//float Scalenumber =atan2f(sin(2.0*M_PI *i/PHOTONUM));
		float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.3)
		{
			Scalenumber = 0.4;
		}
		CATransform3D rotationTransform = CATransform3DIdentity;
		rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);
		addview1.layer.transform=rotationTransform;
		[self.view addSubview:addview1];
		
	}
	currenttag = TAGSTART;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Clickup:(NSInteger)tag
{
    //	int = currenttag - tag;
	if(currenttag == tag)
    {
        
        switch (tag) {
            case 1000:  //销售热线
            {
                NSString *number = @"057188280111";// 此处读入电话号码
                
                // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
                
                NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
                break;
            }
            case 1001:  //售后服务
            {
                NSString *number = @"057188280111";// 此处读入电话号码
                
                // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
                
                NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
                break;
            }
            case 1002:  //企业官网
            {
                NSString *iTunesLink;
                iTunesLink = @"http://www.kdqm.com";
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
                
//                UIViewController *detailsViewController = [[UIViewController alloc] init];
//                UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height)];
//                NSURL *url =[NSURL URLWithString:@"http://www.kdqm.com"];
//                NSURLRequest *request =[NSURLRequest requestWithURL:url];
//                [webView loadRequest:request];
//                [detailsViewController.view addSubview:webView];
//                [webView release];
//                [[self navigationController] pushViewController:detailsViewController animated:YES];
//                [detailsViewController release];
                break;
            }
            case 1003:  //车贷方案
            {
                UIViewController *detailsViewController = [[UIViewController alloc] init];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chedai.jpg"]];
                [imageView setFrame:CGRectMake(1, 1, self.view.frame.size.width-2, 150)];
                [detailsViewController.view addSubview:imageView];
                [imageView release];
                UIImageView *imageViewjia = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chedaijia.png"]];
                [imageViewjia setFrame:CGRectMake(1, 151, self.view.frame.size.width-2, self.view.frame.size.height-151)];
                [detailsViewController.view addSubview:imageViewjia];
                [imageViewjia release];
                [[self navigationController] pushViewController:detailsViewController animated:YES];
                [detailsViewController release];
                break;
            }
            case 1004:  //网点地图
            {
                MapViewController *detailsViewController = [[MapViewController alloc] init];
                                
                [[self navigationController] pushViewController:detailsViewController animated:YES];
                [detailsViewController release];
                break;
            }
            default:
                break;
        }
    }
    else
    {
        int t = [self getblank:tag];
        UIImageView *imgview;
        for (int i = 0;i<PHOTONUM;i++ )
        {
            imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];
            [imgview.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
            [imgview.layer addAnimation:[self setscale:TAGSTART+i clicktag:tag] forKey:@"transform"];
        }
        currenttag = tag;
    }
}
-(void)setcurrenttag
{
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ )
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];
		int j = array[currenttag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.3)
		{
			Scalenumber = 0.4;
		}
		CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		imgview.layer.transform=dtmp;
	}
}

-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag
{
	int i = array[clicktag - TAGSTART][tag - TAGSTART];
	int i1 = array[currenttag - TAGSTART][tag - TAGSTART];
	float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
	float Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
	if (Scalenumber<0.3)
	{
		Scalenumber = 0.4;
	}
	CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.duration = TIME;
	animation.repeatCount =1;
	
	
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
	animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
	animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
	animation.autoreverses = NO;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	//imgview.layer.transform=dtmp;
	
	return animation;
}

-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num
{
	// CALayer
	UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];
	CGMutablePathRef path = CGPathCreateMutable();
	//NSLog(@"原点%f原点%f",imgview.layer.position.x,imgview.layer.position.y);
	CGPathMoveToPoint(path, NULL,imgview.layer.position.x,imgview.layer.position.y);
	
	int p =  [self getblank:tag];
	//NSLog(@"旋转%d",p);
	float f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
	float h = f + 2.0*M_PI *num/PHOTONUM;
	float centery = self.view.center.y - 50;
	float centerx = self.view.center.x;
	float tmpy =  centery + RADIUS*cos(h);
	float tmpx =	centerx - RADIUS*sin(h);
	imgview.center = CGPointMake(tmpx,tmpy);
	
	CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);
	animation.path = path;
	CGPathRelease(path);
	animation.duration = TIME;
	animation.repeatCount = 1;
 	animation.calculationMode = @"paced";
	return animation;
}


-(NSInteger)getblank:(NSInteger)tag
{
	if (currenttag>tag)
	{
		return currenttag - tag;
	}
	else
	{
		return PHOTONUM  - tag + currenttag;
	}
    
}

-(void)Scale
{
	[UIView beginAnimations:nil context:self];
	[UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:1];
	
	CATransform3D rotationTransform = CATransform3DIdentity;
    
    rotationTransform = CATransform3DRotate(rotationTransform,3.14, 1.0, 0.0, 0.0);
	
	self.view.layer.transform=rotationTransform;
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

@end
