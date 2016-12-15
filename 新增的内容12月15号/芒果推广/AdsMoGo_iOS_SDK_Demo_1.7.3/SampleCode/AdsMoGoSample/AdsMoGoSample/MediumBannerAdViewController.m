//
//  MediumBannerAdViewController.m
//  MoGoSample_iPad
//
//  Created by MOGO on 12-12-21.
//
//

#import "MediumBannerAdViewController.h"
#import "AdsMOGOContent.h"
@interface MediumBannerAdViewController ()

@end

@implementation MediumBannerAdViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [AdsMOGOContent shareSingleton].title = @"小横幅";
    [AdsMOGOContent shareSingleton].url = @"your url";
    [[AdsMOGOContent shareSingleton] setCatType:CatTypeVideoParent_Child,CatTypeNewsEncyclopedia,CatTypeListenBookLiterature,CatTypeBookChineseClassics,nil];
    [[AdsMOGOContent shareSingleton]setkeyWords:@"your key words",nil];
    
    // Do any additional setup after loading the view from its nib.
    _mediumAd = [[AdMoGoView alloc] initWithAppKey:MoGo_ID_IPad
                                               adType:AdViewTypeMediumBanner                                   adMoGoViewDelegate:self];
    _mediumAd.adWebBrowswerDelegate = self;
    _mediumAd.frame = CGRectMake(0.0, 100.0, 0.0, 0.0);
    [self.view addSubview:_mediumAd];
    [_mediumAd release];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    _mediumAd.adWebBrowswerDelegate = nil;
    _mediumAd.delegate = nil;
    [super dealloc];
}

- (UIViewController *)viewControllerForPresentingModalView
{
	return self;
}

/**
 * 广告开始请求回调
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告开始请求回调");
}

/**
 * 广告接收成功回调
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告接收成功回调");
}

/**
 * 广告接收失败回调
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error
{
    NSLog(@"广告接收失败回调");
}

/**
 * 点击广告回调
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"点击广告回调");
}

/**
 *You can get notified when the user delete the ad
 广告关闭回调
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView
{
    NSLog(@"广告关闭回调");
}

#pragma mark - AdMoGoWebBrowserControllerUserDelegate delegate
/*
 浏览器将要展示
 */
- (void)webBrowserWillAppear
{
    NSLog(@"浏览器将要展示");
}

/*
 浏览器已经展示
 */
- (void)webBrowserDidAppear
{
    NSLog(@"浏览器已经展示");
}

/*
 浏览器将要关闭
 */
- (void)webBrowserWillClosed
{
    NSLog(@"浏览器将要关闭");
}

/*
 浏览器已经关闭
 */
- (void)webBrowserDidClosed
{
    NSLog(@"浏览器已经关闭");
}

/*
 浏览器分享
 url 浏览器打开url
 */
- (void)webBrowserShare:(NSString *)url
{
    NSLog(@"浏览器分享地址 %@",url);
}

@end
