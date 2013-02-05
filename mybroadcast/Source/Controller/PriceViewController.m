//
//  PriceViewController.m
//  mybroadcast
//
//  Created by runes on 12-12-5.
//  Copyright (c) 2012年 runes. All rights reserved.
//

#import "PriceViewController.h"
#import "SysTypeValue.h"
#import "SBJson.h"
#import "MyScrollView.h"

@interface PriceViewController ()

@end

@implementation PriceViewController
@synthesize lName,lLinkTel,lCar,lChepai,lService,lDate,lTime,lMemo;
@synthesize tName,tLinkTel,tCar,tChepai,tService,tDate,tTime,tMemo;
@synthesize sendItem,_label,myAlertView,alertTableView,dataAlertView;
@synthesize _commonUtil,alertListContent,_request,jsonDic;
//@synthesize formatter,datePicker,timestamp;
@synthesize _tag;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _tag = 0;
        _commonUtil = [[CommonUtil alloc] init];
        alertTableView = [[UITableView alloc] initWithFrame: CGRectMake(15, 50, 255, 225)];
        alertTableView.delegate = self;
        alertTableView.dataSource = self;
        alertTableView.tag = 1;
        mData = [NSMutableData new];
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"询价/预约";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/admin/sysbasetype!outputjsonlist.action",_commonUtil._globleUrl]];
    _request= [ASIHTTPRequest requestWithURL:url];
    [_request setDelegate:self];
    [_request startAsynchronous];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, 0, 50, 44)];
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
    sendItem = [[UIBarButtonItem alloc]
                      initWithTitle:@"发送"
                      style:UIBarButtonItemStyleDone
                      target:self
                      action:@selector(submitAction:)];
    sendItem.tag = 1;
    [buttons addObject:sendItem];
    
    [toolbar setItems:buttons animated:NO];
    toolbar.barStyle = -1;
    [buttons release];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:toolbar] autorelease];
    [toolbar release];
    
    UIControl *_back = [[UIControl alloc] initWithFrame:self.view.frame];
    //_back.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"121.png"]];
    MyScrollView *scrollView = [[[MyScrollView alloc] initWithFrame:self.view.frame] autorelease];
    [scrollView setScrollEnabled:YES];
    scrollView.showsVerticalScrollIndicator = TRUE;
    scrollView.delaysContentTouches = NO;
    
    [(UIControl *)_back addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    //self.view = _back;
    [scrollView addSubview:_back];
    [_back release];
    
    int xlabel = 20;
    int ylabel = 0;
    int wlabel = 70;
    int hlabel = 30;
    
    int xfield = 100;
    int yfield = 0;
    int wfield = 200;
    int hfield = 30;
    
    _info = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, self.view.frame.size.width-35, 90)];
    _info.text = @"尊敬的朋友:\n       请填写您的基本信息,我们将精心为您打造尊崇的服务、丰富的咨讯并为您提供大量的优惠信息,我们热忱的欢迎您到店赏车!";
    _info.font = [UIFont systemFontOfSize:14];
    _info.lineBreakMode = NSLineBreakByWordWrapping;
    _info.numberOfLines = 5;
    _info.highlighted = YES;
    _info.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:_info];
    
    ylabel = ylabel + 90;
    yfield = yfield + 90;
    
    lName = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, wlabel, hlabel)];
    lName.text = @"姓名";
    lName.highlighted = YES;
    lName.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lName];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(xlabel+70, ylabel, 10, 20)];
    _label.textColor = [UIColor redColor];
    _label.text = @"*";
    _label.highlighted = YES;
    _label.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:_label];
    
    tName = [[UITextField alloc] initWithFrame:CGRectMake(xfield, yfield, wfield, hfield)];
    tName.backgroundColor = [UIColor clearColor];
    tName.borderStyle = UITextBorderStyleRoundedRect;
    tName.placeholder = @"请填写您的姓名";
    tName.delegate = self;
    [scrollView addSubview:tName];
    
    ylabel = ylabel + 40;
    yfield = yfield + 40;
    
    lLinkTel = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, wlabel, hlabel)];
    lLinkTel.text = @"联系电话";
    lLinkTel.highlighted = YES;
    lLinkTel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lLinkTel];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(xlabel+70, ylabel, 10, 20)];
    _label.textColor = [UIColor redColor];
    _label.text = @"*";
    _label.highlighted = YES;
    _label.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:_label];
    
    tLinkTel = [[UITextField alloc] initWithFrame:CGRectMake(xfield, yfield, wfield, hfield)];
    tLinkTel.backgroundColor = [UIColor clearColor];
    tLinkTel.borderStyle = UITextBorderStyleRoundedRect;
    tLinkTel.placeholder = @"请填写电话号码";
    tLinkTel.delegate = self;
    [scrollView addSubview:tLinkTel];
    
    ylabel = ylabel + 40;
    yfield = yfield + 40;
    
    lCar = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, wlabel, hlabel)];
    lCar.text = @"车型";
    lCar.highlighted = YES;
    lCar.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lCar];
    
    tCar = [[UITextField alloc] initWithFrame:CGRectMake(xfield, yfield, wfield, hfield)];
    tCar.backgroundColor = [UIColor clearColor];
    tCar.borderStyle = UITextBorderStyleRoundedRect;
    tCar.placeholder = @"车辆型号;无则不填";
    //tCar.delegate = self;
    tCar.tag = 2;
    [tCar addTarget:self action:@selector(dropdown:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:tCar];
    
    ylabel = ylabel + 40;
    yfield = yfield + 40;
    
    lChepai = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, wlabel, hlabel)];
    lChepai.text = @"车牌号";
    lChepai.highlighted = YES;
    lChepai.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lChepai];
    
    tChepai = [[UITextField alloc] initWithFrame:CGRectMake(xfield, yfield, wfield, hfield)];
    tChepai.backgroundColor = [UIColor clearColor];
    tChepai.borderStyle = UITextBorderStyleRoundedRect;
    tChepai.placeholder = @"车牌号码;无则不填";
    tChepai.delegate = self;
    [scrollView addSubview:tChepai];
    
    ylabel = ylabel + 40;
    yfield = yfield + 40;
    
    lService = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, wlabel, hlabel)];
    lService.text = @"服务类型";
    lService.highlighted = YES;
    lService.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lService];
    
    tService = [[UITextField alloc] initWithFrame:CGRectMake(xfield, yfield, wfield, hfield)];
    tService.backgroundColor = [UIColor clearColor];
    tService.borderStyle = UITextBorderStyleRoundedRect;
    //tService.delegate = self;
    tService.placeholder = @"选择服务类型";
    tService.tag = 1;
    [tService addTarget:self action:@selector(dropdown:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:tService];
    
    ylabel = ylabel + 40;
    yfield = yfield + 40;
    
    lDate = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, wlabel, hlabel)];
    lDate.text = @"日期";
    lDate.highlighted = YES;
    lDate.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lDate];
    
    tDate = [[UITextField alloc] initWithFrame:CGRectMake(xfield, yfield, wfield, hfield)];
    tDate.backgroundColor = [UIColor clearColor];
    tDate.borderStyle = UITextBorderStyleRoundedRect;
    tDate.delegate = self;
    UIDatePicker *dPicker = [[[UIDatePicker alloc]init] autorelease];
    [dPicker setDatePickerMode:UIDatePickerModeDate];
    tDate.inputView = dPicker;
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"yyyy-MM-dd";
    //NSTimeInterval interval = 24*60*60*1;
    NSDate *date = [[NSDate alloc] init];
    NSString *timestamp = [formatter stringFromDate:date];
    tDate.text = timestamp;
    [date release];
    [dPicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventAllEvents];
    [scrollView addSubview:tDate];
    
    ylabel = ylabel + 40;
    yfield = yfield + 40;
    
    lTime = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, wlabel, hlabel)];
    lTime.text = @"时间";
    lTime.highlighted = YES;
    lTime.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lTime];
    
    tTime = [[UITextField alloc] initWithFrame:CGRectMake(xfield, yfield, wfield, hfield)];
    tTime.backgroundColor = [UIColor clearColor];
    tTime.borderStyle = UITextBorderStyleRoundedRect;
    tTime.delegate = self;
    UIDatePicker *timePicker = [[[UIDatePicker alloc]init] autorelease];
    [timePicker setDatePickerMode:UIDatePickerModeTime];
    tTime.inputView = timePicker;
    tTime.text = @"09点00分";
    [timePicker addTarget:self action:@selector(timePickerValueChanged:) forControlEvents:UIControlEventAllEvents];
    [scrollView addSubview:tTime];
    
    ylabel = ylabel + 40;
    yfield = yfield + 40;
    
    lMemo = [[UILabel alloc] initWithFrame:CGRectMake(xlabel, ylabel, wlabel, hlabel)];
    lMemo.text = @"备注";
    lMemo.highlighted = YES;
    lMemo.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:lMemo];
    
    tMemo = [[UITextField alloc] initWithFrame:CGRectMake(xfield, yfield, wfield, hfield)];
    tMemo.backgroundColor = [UIColor clearColor];
    tMemo.borderStyle = UITextBorderStyleRoundedRect;
    tMemo.delegate = self;
    [scrollView addSubview:tMemo];
    
    ylabel = ylabel + 40;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, ylabel);
    self.view = scrollView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [imageView setImage:[UIImage imageNamed:@"Default.png"]];
    imageView.alpha = 0.3;
    [self.view addSubview:imageView];
    [imageView release];
    
    myAlertView = [[UIAlertView alloc] initWithTitle: @"信息提示"
                                             message: @""
                                            delegate: nil
                                   cancelButtonTitle: @"确定"
                                   otherButtonTitles: nil];
    
    dataAlertView = [[UIAlertView alloc] initWithTitle: @"请选择一个分类"
                                                    message: @"\n\n\n\n\n\n\n\n\n\n\n"
                                                   delegate: nil
                                          cancelButtonTitle: @"取消"
                                     otherButtonTitles: nil];
    
    [super viewDidLoad];
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
        jsonDic = [jsonDic objectForKey:@"SysTypeValues"];
        [error release];
    }
    [responseData release];
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES];
}

- (void)timePickerValueChanged:(id)sender
{
	UIDatePicker *datePicker = (UIDatePicker*)sender;
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"HH点mi分";
	NSString *timestamp = [formatter stringFromDate:datePicker.date];
    tTime.text = timestamp;
}

- (void)datePickerValueChanged:(id)sender
{
	UIDatePicker *datePicker = (UIDatePicker*)sender;
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"yyyy-MM-dd";
	NSString *timestamp = [formatter stringFromDate:datePicker.date];
    tDate.text = timestamp;
}

- (void)dropdown:(id)sender
{
    UITextField *textField = (UITextField*)sender;
    self._tag = textField.tag;
    if (self._tag == 1) {
        dataAlertView.title = @"请选择服务类型";
    }
    else if (self._tag == 2) {
        dataAlertView.title = @"请选择车型";
    }
    [self fiterDict];
    [alertTableView reloadData];
    [dataAlertView addSubview: alertTableView];
    [dataAlertView show];
}

- (void)fiterDict
{
    SysTypeValue *stv;
    alertListContent = [[NSMutableArray alloc] init];
    if (jsonDic) {
        for (NSDictionary* dictionary in jsonDic) {
            stv = [[[SysTypeValue alloc] init] autorelease];
            stv.sId = [dictionary objectForKey:@"id"];
            stv.sTypeId = [[dictionary objectForKey:@"typeId"] intValue];
            stv.sName = [dictionary objectForKey:@"name"];
            stv.sNameNls = [dictionary objectForKey:@"nameNls"];
            if (self._tag == 2 && stv.sTypeId == 200) {
                [alertListContent addObject:stv];
            }
            else if (self._tag == 1 && stv.sTypeId == 100) {
                [alertListContent addObject:stv];
            }
        }
    }
//    [self.view reloadData];
}

- (void)submitAction:(id)sender
{
    if (tName.text.length == 0) {
        myAlertView.title = @"请填写您的姓名";
        [myAlertView show];
    }
    else if (tLinkTel.text.length == 0) {
        myAlertView.title = @"请填写您的联系电话,方便我们与您联系!";
        [myAlertView show];
    }
    else{
        //参数1名字=参数1数据&参数2名字＝参数2数据&参数3名字＝参数3数据&...
        NSString *post = [NSString stringWithFormat:@"uiName=%@&uiLinkTel=%@&uiCar=%@&uiChepai=%@&uiService=%@&uiDate=%@&uiTime=%@&uiMemo=%@",tName.text,tLinkTel.text,tCar.text,tChepai.text,tService.text,tDate.text,tTime.text,tMemo.text];
        
        //NSLog(@"post:%@",post);
        
        //将NSSrring格式的参数转换格式为NSData，POST提交必须用NSData数据。
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        //计算POST提交数据的长度
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        //NSLog(@"postLength=%@",postLength);
        //定义NSMutableURLRequest
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
        //设置提交目的url
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/userInfo!outputSendUserInfo.action",_commonUtil._globleUrl]]];
        //设置提交方式为 POST
        [request setHTTPMethod:@"POST"];
        //设置http-header:Content-Type
        //这里设置为 application/x-www-form-urlencoded ，如果设置为其它的，比如text/html;charset=utf-8，或者 text/html 等，都会出错。不知道什么原因。
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        //设置http-header:Content-Length
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        //设置需要post提交的内容
        [request setHTTPBody:postData];
        
        //定义
        NSHTTPURLResponse* urlResponse = nil;
        NSError *error = [[NSError alloc] init];
        //同步提交:POST提交并等待返回值（同步），返回值是NSData类型。
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        //将NSData类型的返回值转换成NSString类型
        NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        myAlertView.title = @"发送失败,请稍后重试!";
        if ([@"1" compare:result]==NSOrderedSame) {
            myAlertView.title = @"发送成功,稍后工作人员会与您取得联系!";
            tName.text = nil;
            tLinkTel.text = nil;
            tCar.text = nil;
            tChepai.text = nil;
            tService.text = nil;
            tDate.text = nil;
            tTime.text = nil;
            tMemo.text = nil;
        }
        [myAlertView show];
    }
}

- (void)dealloc
{
    [super dealloc];
    [lName release];
    [lLinkTel release];
    [lCar release];
    [lChepai release];
    [lService release];
    [lDate release];
    [lTime release];
    [lMemo release];
    
    [tName release];
    [tLinkTel release];
    [tCar release];
    [tChepai release];
    [tService release];
    [tDate release];
    [lTime release];
    [tMemo release];
    
    [_label release];
    [alertTableView release];
    [myAlertView release];
    [dataAlertView release];
    [sendItem release];
    
    [alertListContent release];
    [jsonDic release];
    [_request clearDelegatesAndCancel];
    [_request release];
    
//    [self.formatter release];
//    [self.timestamp release];
//    [self.datePicker release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 解决虚拟键盘挡住UITextField的方法
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y- (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
#pragma mark -

#pragma mark -
#pragma mark 触摸背景来关闭虚拟键盘
-(IBAction)backgroundTap:(id)sender
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [tName resignFirstResponder];
    [tLinkTel resignFirstResponder];
    [tChepai resignFirstResponder];
    [tMemo resignFirstResponder];
    [tDate resignFirstResponder];
    [tTime resignFirstResponder];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self._tag > 0){
        return [alertListContent count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    SysTypeValue *stv;
    stv = [alertListContent objectAtIndex:indexPath.row];
    if (self._tag == 1) {
        cell.textLabel.text = stv.sName;
    }
    else if (self._tag == 2) {
        cell.textLabel.text = stv.sName;
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SysTypeValue *stv;
    stv = [alertListContent objectAtIndex:indexPath.row];
    if (self._tag == 1) {
        tService.text = stv.sName;
    }
    else if (self._tag == 2) {
        tCar.text = stv.sName;
    }
    NSUInteger cancelButtonIndex = dataAlertView.cancelButtonIndex;
    [dataAlertView dismissWithClickedButtonIndex: cancelButtonIndex animated: YES];
}

@end
