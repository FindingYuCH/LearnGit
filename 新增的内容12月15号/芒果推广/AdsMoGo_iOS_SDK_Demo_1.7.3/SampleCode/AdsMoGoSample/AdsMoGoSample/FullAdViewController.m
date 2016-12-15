//
//  FullAdViewController20.m
//  TestMOGOSDKAPI
//
//  Created by Daxiong on 14-5-5.
//  Copyright (c) 2014年 Daxiong. All rights reserved.
//

#import "AdMoGoInterstitialDelegate.h"

#import "AdMoGoInterstitialManager.h"
#import "FullAdViewController.h"
#import "AdMoGoLogCenter.h"
#import "AdsMOGOContent.h"

@interface FullAdViewController ()<AdMoGoInterstitialDelegate> {
    BOOL isShowTime;
}

@end

@implementation FullAdViewController
@synthesize adView;
@synthesize adViewType;
@synthesize appkey;
@synthesize expressMode;
@synthesize isRefresh;
@synthesize interval;
@synthesize isVideo;
@synthesize adsMoGoDownloadShowAlert;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isShowTime = NO;
    [AdsMOGOContent shareSingleton].title = @"插屏";
    [AdsMOGOContent shareSingleton].url = @"your url";
    [[AdsMOGOContent shareSingleton] setCatType:CatTypeVideoParent_Child,CatTypeNewsEncyclopedia,CatTypeListenBookLiterature,CatTypeBookChineseClassics,nil];
    [[AdsMOGOContent shareSingleton]setkeyWords:@"your key words",nil];
    
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
    if (isVideo) {
        AdMoGoInterstitial *interstitial_video = [[AdMoGoInterstitialManager shareInstance] adMogoVideoInterstitialByAppKey:self.appkey];
        interstitial_video.delegate = nil;
        [[AdMoGoInterstitialManager shareInstance] removeVideoInterstitialInstanceByAppKey:self.appkey];
    } else {
        AdMoGoInterstitial *interstitial = [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:self.appkey];
        interstitial.delegate = nil;
        [[AdMoGoInterstitialManager shareInstance] removeInterstitialInstanceByAppKey:self.appkey];
    }
    
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
    if (isVideo) {
        [[AdMoGoInterstitialManager shareInstance] adMogoVideoInterstitialByAppKey:self.appkey].delegate = self;
        //更新当前的状态
        UILabel *lab = (UILabel *)[self.view viewWithTag:1002];
        lab.text = [self titleByStatusCode:[[[AdMoGoInterstitialManager shareInstance] adMogoVideoInterstitialByAppKey:self.appkey] performSelector:@selector(getCurrentStatus) withObject:nil]];
    } else {
        AdMoGoInterstitial *interstitialIns = [[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:self.appkey];
        interstitialIns.delegate = self;
        
        //更新当前的状态
        UILabel *lab = (UILabel *)[self.view viewWithTag:1002];
        lab.text = [self titleByStatusCode:[[[AdMoGoInterstitialManager shareInstance]adMogoInterstitialByAppKey:self.appkey] performSelector:@selector(getCurrentStatus) withObject:nil]];
    }
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
    
}

- (IBAction)adBtnAction:(UIButton *)sender
{
    AdMoGoInterstitial *ins = isVideo?[[AdMoGoInterstitialManager shareInstance] adMogoVideoInterstitialByAppKey:self.appkey]:[[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:self.appkey];
    
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

- (void)statusDidChange:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *appKey = [userInfo objectForKey:@"appKey"];
    if (appKey && [appKey isEqualToString:self.appkey]) {
        UILabel *lab = (UILabel *)[self.view viewWithTag:1002];
        lab.text = [self titleByStatusCode:[[userInfo objectForKey:@"status"] intValue]];
    }
}

- (NSString *)titleByStatusCode:(int)scode
{
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
    }else{
        
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
/*
 全屏广告消失
 */
- (void)adsMoGoInterstitialAdDidDismiss
{
    UIButton *btn = (UIButton *)[self.view viewWithTag:1001];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"show Interstitial" forState:UIControlStateNormal];
    AdMoGoInterstitial *ins = isVideo?[[AdMoGoInterstitialManager shareInstance] adMogoVideoInterstitialByAppKey:self.appkey]:[[AdMoGoInterstitialManager shareInstance] adMogoInterstitialByAppKey:self.appkey];
    [ins interstitialCancel];
    isShowTime = !isShowTime;
}

- (UIViewController *)viewControllerForPresentingInterstitialModalView
{
    if (isVideo) {
        return [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return self;
}

- (BOOL)adsMogoInterstitialAdDidExpireAd
{
    return NO;
}

@end
