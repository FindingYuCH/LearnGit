//
//  FullAdNoAutopollingViewController.m
//  AdsMoGoSample
//
//  Created by mogo on 14-3-6.
//  Copyright (c) 2014年 MOGO. All rights reserved.
//

#import "FullAdManualFreshViewController.h"
#import "AdMoGoInterstitialDelegate.h"
#import "AdMoGoInterstitialManager.h"
@interface FullAdManualFreshViewController () {
    BOOL isShowTime;
    BOOL ismanualfreshad;
}
@end

@implementation FullAdManualFreshViewController
@synthesize adView;
@synthesize appkey;
@synthesize timer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isShowTime = NO;
    
    [self initView];
    
    [self addNotification];
    
    [self initAd];
}

- (void)viewDidUnload
{
    [self removeNotification];
}

- (void)dealloc
{
    AdMoGoInterstitial *interstitial = [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:self.appkey];
    interstitial.delegate = nil;
    [[AdMoGoInterstitialManager shareInstance] removeInterstitialInstanceByAppKey:self.appkey];
    [super dealloc];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusDidChange:) name:@"AdMoGoInterstitialStatusChangeNotification"
                                               object:nil];
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initAd
{
    AdMoGoInterstitial *interstitialIns = nil;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        self.appkey = MoGo_ID_IPhone_ManualFresh;
    }else{
        self.appkey = MoGo_ID_IPad_ManualFresh;
    }
        interstitialIns = [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:self.appkey isManualRefresh:YES];
        interstitialIns.delegate = self;
        interstitialIns.adWebBrowswerDelegate = self;
        //更新当前的状态
    UILabel *lab = (UILabel *)[self.view viewWithTag:1002];
    lab.text = [self titleByStatusCode:[[[AdMoGoInterstitialManager shareInstance]adMogoInterstitialByAppKey:self.appkey] performSelector:@selector(getCurrentStatus) withObject:nil]];
}

- (void)initView
{
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];

    //add btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"show Interstitial" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(adBtnAction:) forControlEvents:UIControlEventTouchDown];
    [btn setBackgroundColor:[UIColor greenColor]];
    btn.frame = CGRectMake(0, 0, 250, 44);
    
    CGPoint center = self.view.center;
    if (UIInterfaceOrientationIsLandscape(io)) {
        float x = center.x;
        center.x = center.y;
        center.y = x;
    }
    btn.center = center;
    
    btn.tag = 1001;
    [self.view addSubview:btn];
    
    //add status lable
    float w = UIInterfaceOrientationIsLandscape(io)? MAX(self.view.frame.size.width, self.view.frame.size.height):MIN(self.view.frame.size.width, self.view.frame.size.height);
    CGRect lableFrame = CGRectMake(0, 0, w, 70);
    lableFrame.origin.y = (btn.frame.origin.y - lableFrame.size.height) / 2.0f;
    UILabel *statusLable = [[UILabel alloc] initWithFrame:lableFrame];
    statusLable.textAlignment = NSTextAlignmentCenter;
    statusLable.textColor = [UIColor blackColor];
    statusLable.backgroundColor = [UIColor clearColor];
    statusLable.text = @"初始化";
    statusLable.tag = 1002;
    [self.view addSubview:statusLable];
    [statusLable release];

    UIButton *freshAd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [freshAd setTitle:@"fresh Interstitial" forState:UIControlStateNormal];
    [freshAd addTarget:self action:@selector(freshadBtnAction:) forControlEvents:UIControlEventTouchDown];
    [freshAd setBackgroundColor:[UIColor greenColor]];
    freshAd.frame = CGRectMake(170, 0, 150, 44);
    freshAd.center = CGPointMake(btn.center.x, btn.center.y+60);
    [self.view addSubview:freshAd];
}

- (IBAction)freshadBtnAction:(id)sender
{
    //    [self initAd];
    AdMoGoInterstitial *ins = [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:self.appkey];
    [ins refreshAd];
}

- (void)adBtnAction:(UIButton *)sender{
    
    AdMoGoInterstitial *ins = [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:self.appkey];
    
    if (isShowTime) {
        [sender setBackgroundColor:[UIColor greenColor]];
        [sender setTitle:@"show Interstitial" forState:UIControlStateNormal];
        [ins interstitialCancel];
    } else {
        [sender setBackgroundColor:[UIColor redColor]];
        [sender setTitle:@"exit Interstitial" forState:UIControlStateNormal];
        [ins interstitialShow:YES];
    }
    
    isShowTime = !isShowTime;
}

- (IBAction)quickModeSwitchPressed { }

- (void)statusDidChange:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *appKey = [userInfo objectForKey:@"appKey"];
    if (appKey && [appKey isEqualToString:self.appkey]) {
        UILabel *lab = (UILabel *)[self.view viewWithTag:1002];
        lab.text = [self titleByStatusCode:[[userInfo objectForKey:@"status"] intValue]];
    }
    //    [NSThread callStackReturnAddresses];
}

- (NSString *)titleByStatusCode:(int)scode
{
    //    InterstitialStatusRotating = 0,
    //    InterstitialStatusWaitForTheShow,
    //    InterstitialStatusShow,
    //    InterstitialStatusWaitForRerotate,
    //    InterstitialStatusExpire
    NSString *title = @"未知";
    switch (scode) {
        case 0:
            title = @"轮换中";
            break;
        case 1:
            title = @"等展示";
            break;
        case 2:
            title = @"展示中";
            break;
        case 3:
            title = @"等重启";
            break;
        case 4:
            title = @"已过期";
            break;
        case 5:
            title = @"已销毁";
            break;
        default:
            break;
    }
    
    return title;
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UIInterfaceOrientation io = toInterfaceOrientation;
    UIButton *btn = (UIButton *)[self.view viewWithTag:1001];
    CGPoint center = self.view.center;
    if (UIInterfaceOrientationIsLandscape(io)) {
        float x = MAX(center.x, center.y);
        float y = MIN(center.x, center.y);
        center.x = x;
        center.y = y;
    } else {
        float x = MIN(center.x, center.y);
        float y = MAX(center.x, center.y);
        center.x = x;
        center.y = y;
    }
    
    [UIView animateWithDuration:duration animations:^{
        btn.center = center;
        UILabel *lab = (UILabel *)[self.view viewWithTag:1002];
        float w = UIInterfaceOrientationIsLandscape(io)? MAX(self.view.frame.size.width, self.view.frame.size.height):MIN(self.view.frame.size.width, self.view.frame.size.height);
        CGRect lableFrame = CGRectMake(0, 0, w, 70);
        lableFrame.origin.y = (btn.frame.origin.y - lableFrame.size.height) / 2.0f;
        lab.frame = lableFrame;
    }];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
    UIButton *btn = (UIButton *)[self.view viewWithTag:1001];
    CGPoint center = self.view.center;
    if (UIInterfaceOrientationIsLandscape(io)) {
        float x = MAX(center.x, center.y);
        float y = MIN(center.x, center.y);
        center.x = x;
        center.y = y;
    } else {
        float x = MIN(center.x, center.y);
        float y = MAX(center.x, center.y);
        center.x = x;
        center.y = y;
    }
    
    btn.center = center;
    
    UILabel *lab = (UILabel *)[self.view viewWithTag:1002];
    float w = UIInterfaceOrientationIsLandscape(io)? MAX(self.view.frame.size.width, self.view.frame.size.height):MIN(self.view.frame.size.width, self.view.frame.size.height);
    CGRect lableFrame = CGRectMake(0, 0, w, 70);
    lableFrame.origin.y = (btn.frame.origin.y - lableFrame.size.height) / 2.0f;
    lab.frame = lableFrame;
}

#pragma mark - AdMoGoInterstitialDelegate method

- (void)adMoGoInterstitialInitFinish
{
//    [self freshadBtnAction:nil];
}

/*
 全屏广告消失
 */
- (void)adsMoGoInterstitialAdDidDismiss
{
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:1001];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"show Interstitial" forState:UIControlStateNormal];
    [[AdMoGoInterstitialManager shareInstance] interstitialCancel];
    isShowTime = !isShowTime;
}

- (UIViewController *)viewControllerForPresentingInterstitialModalView
{
    return self;
}

- (void)adMoGoInterstitialInMaualfreshAllAdsFail
{
//    [self freshadBtnAction:nil];
}

@end
