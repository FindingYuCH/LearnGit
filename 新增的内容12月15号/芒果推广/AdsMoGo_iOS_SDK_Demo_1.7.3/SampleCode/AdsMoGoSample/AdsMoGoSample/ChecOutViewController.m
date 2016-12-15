//
//  ChecOutViewController.m
//  TestMOGOSDKAPP
//
//  Created by mogo_wenyand on 14-1-21.
//
//

#import "ChecOutViewController.h"

@interface ChecOutViewController ()

@end

@implementation ChecOutViewController
@synthesize appkey;

- (void)viewDidLoad
{
    [super viewDidLoad];
    usecustomVersion = NO;
    // Do any additional setup after loading the view.
    UIButton *checkButAlert = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkButAlert setFrame:CGRectMake(50.0, 60.0, 150.0, 40.0)];
    [checkButAlert setTitle:@"更新提醒(alert)" forState:UIControlStateNormal];
    [checkButAlert addTarget:self action:@selector(checkOutAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkButAlert];
    
    UIButton *checkBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkBut setFrame:CGRectMake(50.0, 110.0, 150.0, 40.0)];
    checkBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [checkBut setTitle:@"更新提醒(log)" forState:UIControlStateNormal];
    [checkBut addTarget:self action:@selector(checkOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBut];
    
    
    UIButton *immediateUpdateAlertBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [immediateUpdateAlertBut setTitle:@"立即更新提醒(alert)" forState:UIControlStateNormal];
    [immediateUpdateAlertBut setFrame:CGRectMake(50.0, 160.0, 150.0, 40.0)];
    [immediateUpdateAlertBut addTarget:self action:@selector(immediateUpdateAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:immediateUpdateAlertBut];
    
    
    UIButton *immediateUpdateBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [immediateUpdateBut setTitle:@"立即更新提醒(log)" forState:UIControlStateNormal];
    [immediateUpdateBut setFrame:CGRectMake(50.0, 210.0, 180.0, 40.0)];
    [immediateUpdateBut addTarget:self action:@selector(immediateUpdate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:immediateUpdateBut];
    
    UILabel *textlabael = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 260.0,180.0, 40.0)];
    textlabael.text = @"是否使用自定义版本号";
    [self.view addSubview:textlabael];
    [textlabael release];
    
    UISwitch *customerVersionSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [customerVersionSwitch setOn:usecustomVersion animated:NO];
    CGRect rect = customerVersionSwitch.frame;
    rect.origin.x = 100;
    rect.origin.y = 310;
    customerVersionSwitch.frame = rect;
    [customerVersionSwitch addTarget:self action:@selector(customerVersionSwitchPressed:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:customerVersionSwitch];
    [customerVersionSwitch release];
    
}

- (void)customerVersionSwitchPressed:(id)sender
{
    UISwitch *express = (UISwitch *)sender;
    if (express.on != usecustomVersion) {
        usecustomVersion = express.on;
    }
}

- (void)checkOutAlert
{
    if (updateRemindAlert) {
        [updateRemindAlert release], updateRemindAlert = nil;
    }
    
    if (usecustomVersion) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        updateRemindAlert = [[AdMoGoAppUpdateRemind alloc] initWithAppKey:MoGo_ID_IPhone withDelegate:nil withAppVersion:version];
    } else {
        updateRemindAlert = [[AdMoGoAppUpdateRemind alloc] initWithAppKey:MoGo_ID_IPhone withDelegate:nil];
    }
}

- (void)checkOut
{
    if (updateRemind) {
        [updateRemind release], updateRemind = nil;
    }
    
    if (usecustomVersion) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        updateRemind = [[AdMoGoAppUpdateRemind alloc] initWithAppKey:MoGo_ID_IPhone withDelegate:self withAppVersion:version];
    }else{
        updateRemind = [[AdMoGoAppUpdateRemind alloc] initWithAppKey:MoGo_ID_IPhone withDelegate:self];
    }
}

- (void)immediateUpdateAlert
{
    if (immediateUpdateAlert) {
        [immediateUpdateAlert release], immediateUpdateAlert = nil;
    }
    
    if (usecustomVersion) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        immediateUpdateAlert = [[AdMoGoAppUpdateRemind alloc] initImmeWithAppKey:MoGo_ID_IPhone withDelegate:nil withAppVersion:version];
    } else {
        immediateUpdateAlert = [[AdMoGoAppUpdateRemind alloc] initImmeWithAppKey:MoGo_ID_IPhone withDelegate:nil];
    }
}

- (void)immediateUpdate
{
    if (immediateUpdate) {
        [immediateUpdate release], immediateUpdate = nil;
    }
    
    if (usecustomVersion) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        immediateUpdateAlert = [[AdMoGoAppUpdateRemind alloc] initImmeWithAppKey:MoGo_ID_IPhone withDelegate:self withAppVersion:version];
    } else {
        immediateUpdate = [[AdMoGoAppUpdateRemind alloc] initImmeWithAppKey:MoGo_ID_IPhone withDelegate:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [updateRemindAlert release], updateRemindAlert = nil;
    [updateRemind release], updateRemind = nil;
    [immediateUpdateAlert release], immediateUpdate = nil;
    [immediateUpdate release], immediateUpdate = nil;
    [super dealloc];
}

#pragma mark - AdMoGoAppUpdateRemindDelegate
- (void)appUpdateRemindReturnedInfo:(NSDictionary *)dic
{
    NSLog(@"%s",__func__);
    NSLog(@"%@",dic);
}


@end
